//
//  Globals.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import Foundation
import UIKit
import CFNetwork
import WebKit
import SVProgressHUD
import UserNotifications


// MARK:- _______________ GENRAL _______________
// MARK:

// MARK: APP DELEGATE
let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)


// MARK: IMAGE
func ImageNamed(name:String) -> UIImage?{
	return UIImage(named: name)
}



// MARK:   GET MAIN STORYBOARD
let storyBoard = UIStoryboard(name: Devices.isIpad ? "Storyboard-Ipad" : "Main", bundle: nil)



// MARK:- _______________ NETWORK ACTIVITY INDICATOR _______________
// MARK:

func showActivityIndicator(){
    UIApplication.shared.isNetworkActivityIndicatorVisible =  true
}

func hideActivityIndicator(){
    UIApplication.shared.isNetworkActivityIndicatorVisible =  false
}


// MARK:- _______________ CUSTOM LOADER _______________
// MARK:
func showLoader(){
    showLoaderWithText(text: "")
}

func showLoaderWithText(text:String){
    
    SVProgressHUD.setDefaultStyle(.custom)
    SVProgressHUD.setDefaultMaskType(.custom)
    SVProgressHUD.setDefaultAnimationType(.flat)
    SVProgressHUD.setBackgroundColor(UIColor.clear)
    SVProgressHUD.setRingRadius(30)
    SVProgressHUD.setRingThickness(5)
    SVProgressHUD.setForegroundColor(UIColor.AppColor.colorWhite)
    
    if(text.characters.count > 0){
        SVProgressHUD.show(withStatus: text)
    }else{
        SVProgressHUD.show()
    }
}

func hideLoader(){
    SVProgressHUD.dismiss()
}


// MARK:- _______________ USER DEFAULTS _______________
// MARK:

func setUserDefaultsFor(object:AnyObject, with key:String) {
    UserDefaults.standard.set(object, forKey: key)
    UserDefaults.standard.synchronize()
}

func getUserDefaultsForKey(key:String) -> AnyObject? {
    return UserDefaults.standard.object(forKey: key) as AnyObject?
}

func removeUserDefaultsFor(key:String) {
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}


// MARK:-  _______________ SET MODEL DATA IN USERDEFAULTS _______________
// MARK:

func setModelDataInUserDefaults(key:String,value:Any){
    let data :Data = NSKeyedArchiver.archivedData(withRootObject: value)
    setUserDefaultsFor(object: data as AnyObject, with: key)
}

func getModelDataFromUserDefaults(key:String) -> Any? {
    if let object = getUserDefaultsForKey(key: key) {
        return NSKeyedUnarchiver.unarchiveObject(with: object as! Data)
    }
    return nil
}


// MARK:- _______________ USER NOTIFICATION _______________
// MARK:

func postNotificatio_REGISTER(viewConroller:UIViewController,key:String,selector : Selector) {
    NotificationCenter.default.addObserver(viewConroller,
                                           selector: selector,
                                           name: NSNotification.Name(rawValue: key),
                                           object: nil)
}

func postNotificatio_CALL(key:String) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: key), object: nil)
}

func postNotificatio_REMOVE(viewConroller:UIViewController,key:String) {
    NotificationCenter.default.removeObserver(viewConroller,
                                              name: NSNotification.Name(rawValue: key),
                                              object: nil)
}


// MARK:- _______________ PROPORTIONAL SIZE _______________
// MARK:


// MARK: - Get Proportional Type
func getProportionalWidth(width:CGFloat) -> CGFloat {
    return ((Devices.screenWidth * width)/750)
}
func getProportionalHeight(height:CGFloat) -> CGFloat {
    return ((Devices.screenHeight * height)/1334)
}


// MARK:- SYSTEM VERSION CHECK
// MARK:
func SYSTEM_VERSION_EQUAL_TO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedSame
}

func SYSTEM_VERSION_GREATER_THAN(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending
}

func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) != ComparisonResult.orderedAscending
}

func SYSTEM_VERSION_LESS_THAN(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
}

func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) != ComparisonResult.orderedDescending
}







// MARK:- SYSTEM VERSION CHECK
// MARK:


func checkUNUserNotification() {
    
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        // Enable or disable features based on authorization.
    }
    
}




/*
func setUILocalNotification(notificationDate:Date) {
    

    
     let notification = UNUserNotificationCenter.current()
    
        let notification = UILocalNotification()
    
        /* Time and timezone settings */
        notification.fireDate =  Date(timeIntervalSinceNow: 8.0)
        notification.repeatInterval = NSCalendar.Unit.day
        notification.timeZone = NSCalendar.current.timeZone
        notification.alertBody = "A new item is downloaded."
    
        /* Action settings */
        notification.hasAction = true
        notification.alertAction = "View"
    
        /* Badge settings */
        notification.applicationIconBadgeNumber =
            UIApplication.shared.applicationIconBadgeNumber + 1
        /* Additional information, user info */
        notification.userInfo = [
            "Key 1" : "Value 1",
            "Key 2" : "Value 2"
        ]
    
        /* Schedule the notification */
        UIApplication.shared.scheduleLocalNotification(notification)
    
    
    }


*/








