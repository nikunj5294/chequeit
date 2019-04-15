//
//  AppDelegate.swift
//  LLENA
//
//  Created by Govind ravaliya on 19/10/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit
import CoreData
import UserNotifications
import UserNotificationsUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate,AKSideMenuDelegate {
    
    
    //MARK:- PROPERTIES
    var window: UIWindow?
    //var tabBarApp: AITabBarController?
    var notificatTypes : notificationType! = .Breakfast
    var locationTracker : LocationTracker = LocationTracker()
    
    
    
    
    
    //MARK:- APP LIFE CYCLE
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        sleep(2)
        
        doGeneralSetup()
        
        doSetupUserFlow()
        
        
        //doSetupPushNotificaion(application: application, launchOptions: launchOptions)
        
        checkUNUserNotification()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("\n\nWILL ENTER FG")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("\n\nDID BECOME ACTIVE")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
    
    
    //MARK:- GENERAL SETUP
    
    func doGeneralSetup() {
        
        self.window?.backgroundColor =  UIColor.AppColor.colorAppGreen
        
        // NAVIGATION BAR
        UINavigationBar.appearance().tintColor = UIColor.AppColor.colorBlack
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:  UIColor.AppColor.colorBlack, NSAttributedStringKey.font: UIFont.appFont_Bold(fontSize: CGFloat(17).proportionalFontSize())]
    }
    
    func doSetupUserFlow() {
        
        print("\nUSER LOGGED IN : \(SharedUser.isLoggedIn)")
        SharedUser.loadUserIfNeeded()
        
        if getUserDefaultsForKey(key: AppKeys.keyLoggedIn) != nil{
       
            if (getUserDefaultsForKey(key: AppKeys.keyLoggedIn) as! Bool) == true{
             
                if getUserDefaultsForKey(key: AppKeys.keyWalkthroughFinish) != nil{
                 
                    if (getUserDefaultsForKey(key: AppKeys.keyWalkthroughFinish) as! Bool) == true{
                        self.changeRootToHomeVC()
                    }else{
                        self.changeRootToWalkthroughVC()
                    }
                    
                }else{
                    self.changeRootToHomeVC()
                }
                
            }else{
                self.changeRootWelcomeVC()
            }
            
        }else{
            self.changeRootWelcomeVC()
        }
        
    }
    func changeRootToLoginVC(){
        
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController"))
        appDelegate.window?.rootViewController = navigationController
        
    }
    func changeRootWelcomeVC(){
        
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController"))
        appDelegate.window?.rootViewController = navigationController
        
    }
    
    
    func changeRootToHomeVC(){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: mainStoryboard.instantiateViewController(withIdentifier: "foodFromViewController"))
        let leftView : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuViewController")
        let rightView : UIViewController =  mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuViewController")
        
        
        let sideMenuViewController: AKSideMenu = AKSideMenu(contentViewController: navigationController, leftMenuViewController: leftView, rightMenuViewController: rightView)
        
        
        
        sideMenuViewController.delegate = self
        sideMenuViewController.menuPreferredStatusBarStyle = UIStatusBarStyle.lightContent
        sideMenuViewController.contentViewShadowColor = UIColor.AppColor.colorBlack
        sideMenuViewController.contentViewShadowOffset = CGSize(width: 0, height: 0)
        sideMenuViewController.contentViewShadowOpacity = 0.6
        sideMenuViewController.contentViewShadowRadius = 12
        sideMenuViewController.contentViewShadowEnabled = true
        sideMenuViewController.bouncesHorizontally = false
        sideMenuViewController.scaleContentView = true
        
        self.window!.rootViewController = sideMenuViewController
        
        
       
        
        
    }
    
    func changeRootToWalkthroughVC(){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController"))
        appDelegate.window?.rootViewController = navigationController
        
        
    }
    
    func changeRootToTabbar() {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
    }
    
    func checkPermissionForLocationPopUp(){
        
        appDelegate.locationTracker = LocationTracker()
        appDelegate.locationTracker.startLocationTracking()
    }
    
    
    
    // MARK: - Core Data Saving support
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("\n\nDOC DIR : \(urls[urls.count-1])\n\n")
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "CommonStructureiOS", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("CommonStructureiOS.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        
        let mOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                        NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: mOptions)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    
    
}

//Register For remote Notification Events
extension AppDelegate {
    
    
    func setUNUserNotification(time: Date, Key: String, message: String) {
        
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "\(AppData.AppName)", arguments: nil)
       // content.subtitle = NSString.localizedUserNotificationString(forKey: "\(AppData.AppName)", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "It’s time for \(message)! Enter your Blood Glucose count.", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared.applicationIconBadgeNumber as NSNumber;
        content.categoryIdentifier = "com.gr. " //"com.elonchan.localNotification"
        content.userInfo = ["type": "\(message)"]
        
        // Deliver the notification in five seconds.
  
        var dateInfo = DateComponents()
        dateInfo.hour = time.hourTwoDigit24Hours_Int
        dateInfo.minute = time.minuteTwoDigit_Int
        
        
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
//        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: time)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 60.0, repeats: true)
        
        var triggerDaily = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        
       //  let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let request = UNNotificationRequest.init(identifier: Key, content: content, trigger: triggerDaily)
        
        // Schedule the notification.
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request){(error) in
            if (error != nil){
                print(error?.localizedDescription)
            }
        }
        
        
//        let center = UNUserNotificationCenter.current()
//        center.add(request) { (erroe) in
//
//            print("notjin")
//        }
        
        //center.add(request)
        
    }
    
    func removeUNUserNotification(key: String){
      
        print("Removed all pending notifications")
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [key])
    }
    
    
    //MARK:- PUSH NOTIFICATION
    func setupPushNotification(){
        if #available(iOS 10.0, *)
        {
            
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [], completionHandler: { (granted, error) in
                if (granted){
                    UIApplication.shared.registerForRemoteNotifications()
                }
            })
            
        }
        else
        { //If user is not on iOS 10 use the old methods we've been using
            let notificationTypes: UIUserNotificationType = [.alert, .badge, .sound]
            let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
            
            UIApplication.shared.registerUserNotificationSettings(pushNotificationSettings)
            UIApplication.shared.registerForRemoteNotifications()
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
    func doSetupPushNotificaion(application:UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        let settings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        
        if let remoteNotification = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable : Any] {
            manageNotification(userInfo: remoteNotification, isThisLaunchOption: true)
        }
    }
    
    func clearNotificationFromCenter(){
        
        if #available(iOS 10.0, *)
        {
            let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications()
        }
        else
        {
            // Fallback on earlier versions
            UIApplication.shared.applicationIconBadgeNumber = 1
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        SharedUser.deviceToken = deviceTokenString
        
        if let vendorId = UIDevice.current.identifierForVendor {
            print("\n\nDEVICE ID : \(vendorId)\n\n")
            NSLog("\n\nDEVICE ID : %@\n\n", vendorId.uuidString)
            SharedUser.deviceId = vendorId.uuidString
        }
        
        print("\n\nPUSH TOKEN : \(deviceTokenString)\n\n")
        NSLog("\n\nPUSH TOKEN : %@\n\n", deviceTokenString)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("\n\nFAILED TO REGISTER REMOTE NOTIFICATION : \(error.localizedDescription)")
        NSLog("\n\nFAILED TO REGISTER REMOTE NOTIFICATION : %@", error.localizedDescription)
    }
    
    //MARK:- didReceiveRemoteNotification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    
        print(response.notification.request.content.userInfo)
        //self.changeRootToGlucoseView()
    
        let userInfo = response.notification.request.content.userInfo
        
        switch userInfo["type"] as? String {
        case "Breakfast"?:
            notificatTypes = .Breakfast
        case "Lunch"?:
            notificatTypes = .Lunch
        case "Dinner"?:
            notificatTypes = .Dinner
        default:
            notificatTypes = .Breakfast
            
        }
        
     //   ["type": "\(message)"]
    
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "setGlucoseValuViewController") as! setGlucoseValuViewController
        vc.notificatTypes = notificatTypes
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: vc)
        appDelegate.window?.rootViewController = navigationController
        
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        
        switch notification.request.identifier {
        case "Breakfast":
            notificatTypes = .Breakfast
        case "Lunch":
            notificatTypes = .Lunch
        case "Dinner":
            notificatTypes = .Dinner
        default:
            notificatTypes = .Breakfast
            
        }
        
        completionHandler( [.alert,.sound,.badge])

        
//        if notification.request.identifier == "requestIdentifier"{
//
//
//        }

        
        
    }

    
  
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        manageNotification(userInfo: userInfo, isThisLaunchOption: false)
    }
    
    //MARK:- MANAGE NOTIFICATION FLOW
    func manageNotification(userInfo:[AnyHashable : Any], isThisLaunchOption:Bool){
        
        let source = isThisLaunchOption ? "FROM LAUNCH" : "FROM DID RECEIVE"
        print("\n\nPUSH NOTIFICATION - \(source) : \(userInfo)")
        NSLog("\n\nPUSH NOTIFICATION - %@ : %@",source,userInfo)
        
        let aps = userInfo["cdata"] as! [String: AnyObject]
        NSLog("cdata: %@", aps)
        self.mangeUserInfo(aps)
    }
    
    func mangeUserInfo(_ userInfo: [AnyHashable: Any]!) {
        
        NSLog("----\(userInfo)")
        
    }
    
}




