//
//  Alert.swift
//  SwiftCodeStructure
//
//  Created by Govind ravaliya on 7/5/16.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit


class Alert: NSObject {

    //static let shared = AIAlertController()
    
    //MARK:- ALERT
    class func showAlertWithTitleFromVC(vc:UIViewController, andMessage message:String, completion:((_ index:Int) -> Void)!) -> Void{
        showAlertWithTitleFromVC(vc: vc, title: AppData.AppName, andMessage: message, buttons: ["Dismiss"]) { (index) in
            completion(index)
        }
    }
    
    
    class func showAlertWithTitleFromVC(vc:UIViewController, title:String, andMessage message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
        
        var newMessage = message
        if newMessage == "The Internet connection appears to be offline." {
            newMessage = AppAlertMessages.message_InternetNotAvailable
        }
        
        let alertController = UIAlertController(title: title, message: newMessage, preferredStyle: .alert)
        for index in 0..<buttons.count    {
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: {
                (alert: UIAlertAction!) in
                if(completion != nil){
                    completion(index)
                }
            })
            
            alertController.addAction(action)
        }
        vc.present(alertController, animated: true, completion: nil)
        
    }
    
    
    // MARK:- ACTION SHEET
    // MARK:
    class func showActionSheetWithTitleFromVC(vc:UIViewController, title:String, andMessage message:String, buttons:[String],canCancel:Bool, completion:((_ index:Int) -> Void)!) -> Void {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        
        for index in 0..<buttons.count    {
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: {
                (alert: UIAlertAction!) in
                if(completion != nil){
                    completion(index)
                }
            })
            
            alertController.addAction(action)
        }
        
        if(canCancel){
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (alert: UIAlertAction!) in
                if(completion != nil){
                    completion(buttons.count)
                }
            })
            
            alertController.addAction(action)
        }
        
        if(Devices.isIpad){
            
            if(vc.view != nil){
                alertController.popoverPresentationController?.sourceView = vc.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: (vc.view?.frame.size.height)!, width: 1.0, height: 1.0)
            }else{
                alertController.popoverPresentationController?.sourceView = UIApplication.shared.delegate!.window!?.rootViewController!.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
            }
        }
       // UIApplication.shared.delegate!.window!?.rootViewController!.present(alertController, animated: true, completion:nil)
        
        vc.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    class func showInternetAlert(){
        
        showAlertWithTitleFromVC(vc: (appDelegate.window?.rootViewController)!, title: AppData.AppName, andMessage: AppAlertMessages.message_InternetNotAvailable, buttons: ["Dismiss"]) { (index) in
        }
    }
}
