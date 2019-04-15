//
//  AIReachabilityManager.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import Foundation
import Reachability

class AIReachabilityManager: NSObject {
	
	private let reachability = Reachability()!
	private var isFirstTimeSetupDone:Bool = false
	private var callCounter:Int = 0
	
	// MARK: - SHARED MANAGER
	static let shared: AIReachabilityManager = AIReachabilityManager()

	
	//MARK:- ALL NETWORK CHECK
	func isInternetAvailableForAllNetworks() -> Bool {
		if(!self.isFirstTimeSetupDone){
			self.isFirstTimeSetupDone = true
			doSetupReachability()
		}
		return reachability.isReachable || reachability.isReachableViaWiFi || reachability.isReachableViaWWAN
	}
	
	
	//MARK:- SETUP
	private func doSetupReachability() {
	
		reachability.whenReachable = { reachability in
			DispatchQueue.main.async {
				self.postIntenetReachabilityDidChangeNotification(isInternetAvailable: true)
			}
		}
		reachability.whenUnreachable = { reachability in
			DispatchQueue.main.async {
				self.postIntenetReachabilityDidChangeNotification(isInternetAvailable: false)
			}
		}
		do{
			try reachability.startNotifier()
		}catch{
		}
	}
	
	deinit {
		reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: nil)
	}

	
	
	//MARK:- NOTIFICATION
	private func postIntenetReachabilityDidChangeNotification(isInternetAvailable isAvailable:Bool){
//		print("\n\n")
//		print("NET REACHABILITY CHANGED : \(isAvailable)")
		
		DispatchQueue.main.async {
			
			if(isAvailable){
				// TO AVOID INITIAL ALERT
				if(self.callCounter != 0){
//                    let dialog = AIDialogueSnackAlert()
//                    dialog.showDialogue(withMessage: "You are now ONLINE", bgColor: UIColor.AppColor.colorGreen, topBottomMargin: 12) { (completion) in
//                    }
				}
			}else{
//                let dialog = AIDialogueSnackAlert()
//                dialog.showDialogue(withMessage: "You are now OFFLINE", bgColor: UIColor.AppColor.colorRed, topBottomMargin: 12) { (completion) in
//                }
			}
			self.callCounter += 1
			
            NotificationCenter.default.post(NSNotification(name: Notification.Name.reachabilityChanged, object: nil) as Notification)

		}
		
	}
}
