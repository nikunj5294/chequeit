//
//  AIDatabaseManager.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit
import CoreData

let DatabaseManager = AIDatabaseManager.shared


class AIDatabaseManager: NSObject {

	//MARK:- SHARED
	static let shared = AIDatabaseManager()
	
	
	//MARK:- USER
	
	func add(user:AIUser, with completion:((_ isSuccess:Bool)->Void)){
		
		isAlreadyAddedUser(userId: user.idUser, with: { (isSuccess) in
		
			if isSuccess {
				
				// IF DUPLICATE USER ID FOUND, THEN UPDATE
				update(user: user, with: { (isSuccess) in
					completion(isSuccess)
				})
			}else{
				
				// ADD NEW USER
				let dbUser = NSEntityDescription.insertNewObject(forEntityName: "DBUser", into: appDelegate.managedObjectContext) as! DBUser
				
				dbUser.accessToken = user.accessToken
				dbUser.deviceId = user.deviceId
				dbUser.deviceToken = user.deviceToken
				
				dbUser.idUser = user.idUser
				dbUser.name = user.name
				dbUser.email = user.email
				dbUser.mobile = user.mobile
				
				dbUser.facebookId = user.facebookId
				dbUser	.googleId = user.googleId

				do{
					try appDelegate.managedObjectContext.save()
					completion(true)
				} catch  {
					completion(false)
				}
			}
		})
	}
	
	func fetchUser(with completion:(_ isSuccess:Bool, _ fetchedUser:AIUser) -> Void) {
		
		let fetchRequest = NSFetchRequest<DBUser>(entityName: "DBUser")
		do{
			let result = try appDelegate.managedObjectContext.fetch(fetchRequest)
			if(result.count > 0){
				completion(true, result.last!.modelUser)
			}else{
				completion(false, AIUser())
			}
		} catch {
			completion(false, AIUser())
		}
	}

	
	func fetchAllUsers(with completion:(_ isSuccess:Bool, _ fetchedUsers:[AIUser]) -> Void) {
		
		let fetchRequest = NSFetchRequest<DBUser>(entityName: "DBUser")
		do{
			let result = try appDelegate.managedObjectContext.fetch(fetchRequest)
			var arrUsers = [AIUser]()
			for each in result{
				arrUsers.append(each.modelUser)
			}
			completion(true, arrUsers)
		} catch {
			completion(false, [])
		}
	}
	
	func isAlreadyAddedUser(userId:String, with completion:(_ isSuccess:Bool) -> Void) {
		
		let fetchRequest = NSFetchRequest<DBUser>(entityName: "DBUser")
		fetchRequest.predicate = NSPredicate(format: "idUser = %@", userId)
		
		do{
			let result = try appDelegate.managedObjectContext.fetch(fetchRequest)
			if(result.count > 0){
				completion(true)
			}else{
				completion(false)
			}
		} catch {
			completion(false)
		}
	}
	
	func update(user:AIUser, with completion:(_ isSuccess:Bool) -> Void) {
		
		let fetchRequest = NSFetchRequest<DBUser>(entityName: "DBUser")
		fetchRequest.predicate = NSPredicate(format: "idUser = %@", user.idUser)
		
		do{
			let result = try appDelegate.managedObjectContext.fetch(fetchRequest)
			if(result.count > 0){
				
				let dbUser = result.last
				
				dbUser?.accessToken = user.accessToken
				dbUser?.deviceId = user.deviceId
				dbUser?.deviceToken = user.deviceToken
				
				dbUser?.idUser = user.idUser
				dbUser?.name = user.name
				dbUser?.email = user.email
				dbUser?.mobile = user.mobile
				
				dbUser?.facebookId = user.facebookId
				dbUser?.googleId = user.googleId
				
				do{
					try appDelegate.managedObjectContext.save()
					completion(true)
				} catch  {
					completion(false)
				}
			}else{
				// IF NO USER ADDED YET THEN ADD USER FOR THE FIRST TIME
				self.add(user: user, with: { (isSuccess) in
					completion(isSuccess)
				})
			}
		} catch {
			completion(false)
		}
	}
	
	func delete(user:AIUser, with completion:(_ isSuccess:Bool) -> Void) {
		
		let fetchRequest = NSFetchRequest<DBUser>(entityName: "DBUser")
		fetchRequest.predicate = NSPredicate(format: "idUser = %@", user.idUser)
		
		do{
			let result = try appDelegate.managedObjectContext.fetch(fetchRequest)
			if(result.count > 0){
				let dbUser = result.last
				appDelegate.managedObjectContext.delete(dbUser!)
				do{
					try appDelegate.managedObjectContext.save()
					completion(true)
				} catch {
					completion(false)
				}
			}else{
				completion(false)
			}
		} catch {
			completion(false)
		}
	}
}
