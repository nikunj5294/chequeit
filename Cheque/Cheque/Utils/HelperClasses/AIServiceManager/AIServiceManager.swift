//
//  AIServiceManager.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit
import Alamofire

let ServiceManager = AIServiceManager.shared


class AIServiceManager: NSObject {
	
	var request: Alamofire.Request? {
		didSet {
			oldValue?.cancel()
		}
	}
	
	// MARK: - SHARED MANAGER
	static let shared = AIServiceManager()
	
	
    
    //MARK: Shared Instance
   // static let shared : ApiServicesManager = ApiServicesManager()
    
    func GET(_ url: String, withCompletion handler: @escaping (DataResponse<Any>) -> Void) {
        if AIReachabilityManager.shared.isInternetAvailableForAllNetworks(){
        //if ReachabilityManager.shared.isInternetAvailable {
            Alamofire.request(url, method: .get, parameters: nil).responseJSON(completionHandler: handler)
        } else {
            Alert.showInternetAlert()
        }
    }
    
    func POST(_ url: String, params: [String : Any]?, withCompletion handler: @escaping (DataResponse<Any>) -> Void) {
        if AIReachabilityManager.shared.isInternetAvailableForAllNetworks() {
            Alamofire.request(url, method: .post, parameters: params).responseJSON(completionHandler: handler)
        } else {
            Alert.showInternetAlert()
        }
    }
    
	//MARK:- LOGIN


	func loginWithType(type:LoginType, params:[String:Any], andCompletion completion:@escaping (_ isSuccess:Bool, _ message:String, _ user:AIUser?) -> Void){
		
		let parameters:[String:Any] = [type.url:getStringFromDictionary(dict: params)]
		
		callPOSTApiWithNetCheck(url: getUrl(type.url), headersRequired: false, params: parameters) { (response, isInternetAvailable) in
			
			if(isInternetAvailable) {
				
				switch response!.result{
					
				case .success(let JSON):
					print("JSON : \(JSON)")
					
					let dictJson = JSON as! NSDictionary
					let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "response")
					
					let status = dictResponse.object_forKeyWithValidationForClass_Int(aKey: "status_code")
					
					if(status == 200){
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						let dictData = dictResponse.object_forKeyWithValidationForClass_NSDictionary(aKey: "data")
						let user = AIUser(dict: dictData)
						
						completion(true,message,user)
					}else{
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						completion(false,message, nil)
					}
					
				case .failure(let error):
					print("ERR : \(error.localizedDescription)")
					completion(false,error.localizedDescription,nil)
				}
			}else{
				completion(false,AppAlertMessages.message_InternetNotAvailable,nil)
			}
		}
	}
	
	
	
	//MARK:-
	
	func signupWith(params:[String:Any], andCompletion completion:@escaping (_ isSuccess:Bool, _ message:String, _ userCreated:AIUser?) -> Void){
		
		print("\nSIGNUP PARAMS : \(getStringFromDictionary(dict: params)) \n")
		
		let parameters:[String:Any] = [endPoint.urlSignUp:getStringFromDictionary(dict: params)]
		
		callPOSTApiWithNetCheck(url: getUrl(endPoint.urlSignUp) , headersRequired: false, params: parameters) { (response, isInternetAvailable) in
			
			if(isInternetAvailable) {
				
				switch response!.result{
					
				case .success(let JSON):
					print("JSON : \(JSON)")
					
					let dictJson = JSON as! NSDictionary
					let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "response")
					
					let status = dictResponse.object_forKeyWithValidationForClass_Int(aKey: "status_code")
					
					if(status == 200){
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						let dictData = dictResponse.object_forKeyWithValidationForClass_NSDictionary(aKey: "data")
						let userCreated = AIUser(dict: dictData)
						
						completion(true,message,userCreated)
					}else{
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						completion(false,message, nil)
					}
					
				case .failure(let error):
					print("ERR : \(error.localizedDescription)")
					completion(false,error.localizedDescription,nil)
				}
			}else{
				completion(false,AppAlertMessages.message_InternetNotAvailable,nil)
			}
		}
	}
	
	func forgotPasswordWith(params:[String:Any], andCompletion completion:@escaping (_ isSuccess:Bool, _ message:String) -> Void){
		
		let parameters:[String:Any] = [endPoint.urlForgotPssword:getStringFromDictionary(dict: params)]
		
		callPOSTApiWithNetCheck(url: getUrl(endPoint.urlForgotPssword) , headersRequired: false, params: parameters) { (response, isInternetAvailable) in
			
			if(isInternetAvailable) {
				
				switch response!.result{
					
				case .success(let JSON):
					print("JSON : \(JSON)")
					
					let dictJson = JSON as! NSDictionary
					let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "response")
					
					let status = dictResponse.object_forKeyWithValidationForClass_Int(aKey: "status_code")
					
					if(status == 200){
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						completion(true,message)
					}else{
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						completion(false,message)
					}
					
				case .failure(let error):
					print("ERR : \(error.localizedDescription)")
					completion(false,error.localizedDescription)
				}
			}else{
				completion(false,AppAlertMessages.message_InternetNotAvailable)
			}
		}
	}
	
	
	func changePasswordWith(params:[String:Any], andCompletion completion:@escaping (_ isSuccess:Bool, _ message:String) -> Void){
		
		let parameters:[String:Any] = [endPoint.urlChangePssword:getStringFromDictionary(dict: params)]
		
		callPOSTApiWithNetCheck(url: getUrl(endPoint.urlChangePssword) , headersRequired: true, params: parameters) { (response, isInternetAvailable) in
			
			if(isInternetAvailable) {
				
				switch response!.result{
					
				case .success(let JSON):
					print("JSON : \(JSON)")
					
					let dictJson = JSON as! NSDictionary
					let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "response")
					
					let status = dictResponse.object_forKeyWithValidationForClass_Int(aKey: "status_code")
					
					if(status == 200){
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						completion(true,message)
					}else{
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						completion(false,message)
					}
					
				case .failure(let error):
					print("ERR : \(error.localizedDescription)")
					completion(false,error.localizedDescription)
				}
			}else{
				completion(false,AppAlertMessages.message_InternetNotAvailable)
			}
		}
	}
	
	func logoutWith(params:[String:Any], andCompletion completion:@escaping (_ isSuccess:Bool, _ message:String) -> Void){
		
		let parameters:[String:Any] = [:]
		
		callGETApiWithNetCheck(url: getUrl(endPoint.urlLogot) , headersRequired: true, params: parameters) { (response, isInternetAvailable) in
			
			if(isInternetAvailable) {
				
				switch response!.result{
					
				case .success(let JSON):
					print("JSON : \(JSON)")
					
					let dictJson = JSON as! NSDictionary
					let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "response")
					
					let status = dictResponse.object_forKeyWithValidationForClass_Int(aKey: "status_code")
					
					if(status == 200){
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						completion(true,message)
					}else{
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						completion(false,message)
					}
					
				case .failure(let error):
					print("ERR : \(error.localizedDescription)")
					completion(false,error.localizedDescription)
				}
			}else{
				completion(false,AppAlertMessages.message_InternetNotAvailable)
			}
		}
	}
	
	
	//MARK:- GET MISSION
	
	func getMissionsWith(_ params:[String:Any], andCompletion completion:@escaping (_ isSuccess:Bool,_ message:String,_ missions:[AIMission],_ totalRecords:Int) -> Void){
		
		let parameters:[String:Any] = [endPoint.urlList:getStringFromDictionary(dict: params)]
		
		// FETCHING DATA CONDITIONALLY FOR GUEST USER
		let isHeaderRequired = SharedUser.isLoggedIn
		
		callPOSTApiWithNetCheck(url: getUrl(endPoint.urlList), headersRequired: isHeaderRequired, params: parameters) { (response, isInternetAvailable) in
			
			if(isInternetAvailable) {
				
				switch response!.result{
					
				case .success(let JSON):
					//					print("JSON : \(JSON)")
					
					let dictJson = JSON as! NSDictionary
					let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "response")
					
					let status = dictResponse.object_forKeyWithValidationForClass_Int(aKey: "status_code")
					
					if(status == 200){
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						let dictData = dictResponse.object_forKeyWithValidationForClass_NSDictionary(aKey: "data")
						
						let arrJSON = dictData.object_forKeyWithValidationForClass_NSArray(aKey: "mission")
						let totalRecords = dictData.object_forKeyWithValidationForClass_Int(aKey: "total_records")
						
						var arrMODEL = [AIMission]()
						for eachDict in arrJSON {
							arrMODEL.append(AIMission(dict: eachDict as! NSDictionary))
						}
						
						
						print("\n\nTOTAL MISSION RECORDS : \(totalRecords)       MODELS : \(arrMODEL.count)\n\n")
						completion(true,message,arrMODEL,totalRecords)
					}else{
						let message = dictResponse.object_forKeyWithValidationForClass_String(aKey: "message")
						completion(false,message, [],0)
					}
					
				case .failure(let error):
					print("ERR : \(error.localizedDescription)")
					completion(false,error.localizedDescription,[],0)
				}
			}else{
				completion(false,AppAlertMessages.message_InternetNotAvailable,[],0)
			}
		}
	}
	
	//MARK:- ******** COMMON POST METHOD *********
	
	private func callGETApiWithNetCheck(url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
		callGET_POSTApiWithNetCheck(isGet: true, url: url, headersRequired: headersRequired, params: params, completionHandler: completionHandler)
	}

	private func callPOSTApiWithNetCheck(url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
		callGET_POSTApiWithNetCheck(isGet: false, url: url, headersRequired: headersRequired, params: params, completionHandler: completionHandler)
	}
	
	private func callGET_POSTApiWithNetCheck(isGet:Bool, url : String, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
		
		if(!isInternetAvailable()){
			//SHOW_INTERNET_ALERT()
			completionHandler(nil,false)
			return
		}
		var headers:[String:String] = [:]
		if headersRequired {
			headers["user_id"] = SharedUser.idUser
			headers["device_id"] = SharedUser.deviceId
			headers["access_token"] = SharedUser.accessToken
		}
		print("\n\n\n\n\nURL : \(url) \nPARAM : \(getStringFromDictionary(dict: params!)) \nHEADERS : \(getStringFromDictionary(dict: headers))")
		
		
		Alamofire.request(url, method: isGet ? .get : .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
			
			switch response.result{
			case .success(let JSON):
				let dictJson = JSON as! NSDictionary
				let dictResponse = dictJson.object_forKeyWithValidationForClass_NSDictionary(aKey: "response")
				let status = dictResponse.object_forKeyWithValidationForClass_Int(aKey: "status_code")
				if(status == 103){
					self.handleInvalidAccessToken()
				}else{
					completionHandler(response,true)
				}
			case .failure( _):
				completionHandler(response,true)
			}
		}
	}
	

	
	
	private func handleInvalidAccessToken(){
	
		hideLoader()
		hideActivityIndicator()
		
        Alert.showAlertWithTitleFromVC(vc: (appDelegate.window?.rootViewController)!, title: AppData.AppName, andMessage: "Session expired ! Just login again", buttons: ["OK"], completion: { (index) in
            SharedUser.logOutLocally(with: { (isSuccess, message) in
                appDelegate.changeRootToLoginVC()
            })
        })
		
	}
	//MARK:- ******** COMMON MULTIPART METHOD *********
	
	
	
	private func callUPLOADApiWithNetCheck(url : String, image:UIImage?, headersRequired : Bool, params : [String : Any]?, completionHandler : @escaping (DataResponse<Any>?,Bool) -> Void){
		
		if(!isInternetAvailable()){
			//SHOW_INTERNET_ALERT()
			completionHandler(nil,false)
			return
		}
		
		var headers:[String:String] = [:]
		if headersRequired {
			headers["user_id"] = SharedUser.idUser
			headers["device_id"] = SharedUser.deviceId
			headers["access_token"] = SharedUser.accessToken
		}

		print("\n\n\n\n\nURL : \(url) \nPARAM : \(getStringFromDictionary(dict: params!)) \nHEADERS : \(getStringFromDictionary(dict: headers))")

		showActivityIndicator()

		Alamofire.upload(multipartFormData:{ multipartFormData in

			if let params = params {
				for eachKey in params.keys {
					if let value = params[eachKey] as? String {
						multipartFormData.append(value.data(using: .utf8)!, withName: eachKey)
					}
				}
			}
			
			if let image = image {
				if let imageData = UIImageJPEGRepresentation(image, 1) {
					multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
				}
			}
		},
		 usingThreshold:UInt64.init(),
		 to:url,
		 method:.post,
		 headers:headers,
		 encodingCompletion: { encodingResult in
			
			hideActivityIndicator()

			switch encodingResult {
			case .success(let upload, _, _):
				upload.responseJSON { response in
					completionHandler(response,true)
				}
			case .failure(let encodingError):
				print("ERR: UPLOAD: \(encodingError.localizedDescription)")
				completionHandler(nil,true)
			}
		})
	}

	func cancellAllPendingRequests(){
		
		let sessionManager = Alamofire.SessionManager.default;
		
		sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in

			print("\n\n")
			
			dataTasks.forEach({ (task) in
                print("1 id : \(task.taskIdentifier) __ \(String(describing: task.currentRequest)) __ \(String(describing: task.originalRequest))")
			})

			dataTasks.forEach({ (task) in
                print("2 id : \(task.taskIdentifier) __ \(String(describing: task.currentRequest)) __ \(String(describing: task.originalRequest))")
			})

			dataTasks.forEach({ (task) in
                print("3 id : \(task.taskIdentifier) __ \(String(describing: task.currentRequest)) __ \(String(describing: task.originalRequest))")
			})

			
			dataTasks.forEach { $0.cancel() }
			uploadTasks.forEach { $0.cancel() }
			downloadTasks.forEach { $0.cancel() }
		}
	}
	
}
