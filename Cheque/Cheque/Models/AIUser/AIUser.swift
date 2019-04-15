//
//  AIUser.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit

enum LoginType:Int {

	case
	none,
	email,
	facebook,
	google
	
	var url:String  {
		switch self {
		case .none:
			return ""
		case .email:
			return endPoint.urlLogin
		case .facebook:
			return endPoint.urlLoginFacebook
		case .google:
			return endPoint.urlGoogle
		}
	}
}

let SharedUser = AIUser.shared

class AIUser: NSObject {
	
	//MARK:- SHARED
	static let shared = AIUser()
	
	
	//MARK:- PROPERTIES
	var idUser:String = ""
	var name:String = ""
	var email:String = ""
	var mobile:String = ""
	
	var isLoaded:Bool = false
	
	var deviceToken:String = ""
	var deviceId:String = ""
	var accessToken:String = ""
	
	var photoUrl:String = ""
	
	
	var currentLatitude : CGFloat = 0
	var currentLongitude : CGFloat = 0

	var hasAnyNotification:Bool = false
	
	var facebookId:String = ""
	var googleId:String = ""
	var socialMediaUrl:String = ""
	
	var loginType:LoginType = .none
	
	var isSocialUser:Bool {
		get {
			print("FB ID : \(SharedUser.facebookId)  GOOGLE ID : \(SharedUser.googleId)")
			return (!SharedUser.facebookId.isEmpty) || (!SharedUser.googleId.isEmpty)
		}
	}
	
	//MARK:- INIT
	override init() {
		super.init()
		
		if let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString {
			self.deviceId = deviceIdentifier
		}

	}
	
	init(dict:NSDictionary) {
	
		self.accessToken = dict.object_forKeyWithValidationForClass_String(aKey: "access_token")
		self.idUser = dict.object_forKeyWithValidationForClass_String(aKey: "user_id")
		
		self.name = dict.object_forKeyWithValidationForClass_String(aKey: "name")
		self.email = dict.object_forKeyWithValidationForClass_String(aKey: "email")
		self.mobile = dict.object_forKeyWithValidationForClass_String(aKey: "mobile_number")
		
		let strPhotoUrl = dict.object_forKeyWithValidationForClass_String(aKey: "profile_picture")
		if !strPhotoUrl.isEmpty{
			self.photoUrl = AppUrl.urlUser + strPhotoUrl
		}else{
			self.photoUrl = dict.object_forKeyWithValidationForClass_String(aKey: "social_media_url")
		}
		
		
		
		if let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString {
			self.deviceId = deviceIdentifier
		}
	
		self.facebookId = dict.object_forKeyWithValidationForClass_String(aKey: "facebook_id")
		self.googleId = dict.object_forKeyWithValidationForClass_String(aKey: "google_id")
	
	}
	
	
	//MARK: - CHECK LOGIN STATUS
	var isLoggedIn:Bool {
		get {
			return getUserDefaultsForKey(key:AppKeys.keyLoggedIn) != nil
		}
	}
	
	
	// MARK: - SAVE
	func saveForAutoLogin(){
		setUserDefaultsFor(object: SharedUser.idUser as AnyObject, with: AppKeys.keyLoggedIn)
	}
	
	//MARK:- LOAD
	
	func loadUserIfNeeded(){
		
		if(SharedUser.isLoggedIn){
			if(!SharedUser.isLoaded){
				SharedUser.loadSavedUser(with: { (isSuccess, loadedUser) in
					if(isSuccess){
						SharedUser.isLoaded = true
					}
				})
			}
		}
	}
	
	func loadSavedUser(with completion:(_ isSuccess:Bool, _ fetchedUser:AIUser) -> Void) {
		
		DatabaseManager.fetchUser { (isSuccess, fetchedUser) in
			
			if(isSuccess){
				
				SharedUser.accessToken = fetchedUser.accessToken
				SharedUser.deviceId = fetchedUser.deviceId
				SharedUser.deviceToken = fetchedUser.deviceToken
				
				SharedUser.idUser = fetchedUser.idUser
				SharedUser.name = fetchedUser.name
				SharedUser.email = fetchedUser.email
				SharedUser.mobile = fetchedUser.mobile

				SharedUser.facebookId = fetchedUser.facebookId
				SharedUser.googleId = fetchedUser.googleId
				
				
				completion(true,SharedUser)
			}else{
				completion(false,AIUser())
			}
		}
	}
	
	
	
	// MARK: - RESET
	func reset(){
		
		SharedUser.accessToken = ""
		//SharedUser.deviceId = "" // DO NOT RESET, BECAUSE WE'RE NOT RESETTING SHARED USER ITSELF, JUST IT'S VALUES
//		SharedUser.deviceToken = ""
		
		SharedUser.idUser = ""
		SharedUser.name = ""
		SharedUser.email = ""
		SharedUser.mobile = ""
		
		SharedUser.isLoaded = false
		
		SharedUser.currentLatitude = 0
		SharedUser.currentLongitude = 0

		SharedUser.arrCategories.removeAll()
		
		SharedUser.hasAnyNotification = false
		
		SharedUser.facebookId = ""
		SharedUser.googleId = ""
		SharedUser.loginType = .none
	}
	
	
	// MARK: - LOG OUT

	func logOut(with completion:@escaping ((Bool,String) -> Void)){
		
		ServiceManager.logoutWith(params: [:]) { (isSuccess, message) in
			if isSuccess {
				// DELETE OTHER DB DATA ALSO
				DatabaseManager.delete(user: SharedUser) { (isSuccess) in
					if(isSuccess){
                        removeUserDefaultsFor(key: AppKeys.keyLoggedIn)
						SharedUser.reset()
						completion(true,message)
					}else{
						completion(false,"Unable to logout at the moment")
					}
				}
			}else{
				completion(false,message)
			}
		}
	}
	
	func logOutLocally(with completion:@escaping ((Bool,String) -> Void)){
		
		DatabaseManager.delete(user: SharedUser) { (isSuccess) in
			if(isSuccess){
                removeUserDefaultsFor(key: AppKeys.keyLoggedIn)
				SharedUser.reset()
				completion(true,"Logout successful")
			}else{
				completion(false,"Unable to logout at the moment")
			}
		}
	}
	
	
	
	// MARK: - UPDATE SHARED USER AND DATABASE
	func updateSharedUserAndDB(user:AIUser){
		
		SharedUser.accessToken = user.accessToken
		SharedUser.deviceId = user.deviceId
		SharedUser.deviceToken = user.deviceToken
		
		SharedUser.idUser = user.idUser
		SharedUser.name = user.name
		SharedUser.email = user.email
		SharedUser.mobile = user.mobile
		
		SharedUser.facebookId = user.facebookId
		SharedUser.googleId = user.googleId
		
		
		
		DatabaseManager.update(user: SharedUser) { (isSuccess) in
			print("UPDATE DB USER : \(isSuccess)")
		}
	}

	
}
