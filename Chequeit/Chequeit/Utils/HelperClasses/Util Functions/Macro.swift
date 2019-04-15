//
//  Macro.swift
//  tableWithCollectionCell
//
//  Created by Govind ravaliya on 14/07/16.
//  Copyright © 2016 Govind ravaliya. All rights reserved.
//

import Foundation
import UIKit


//App Tab Names
struct AppTabName {
    static var new          = "Sounds"
    static var favourites   = "Favourites"
    static var timers       = "Timers"
    static var more         = "More"
    static var premium      = "Premium"
}

//App Font names
struct AppTitle {
    static var home         = "Home"
    static var second       = "Second"
    static var third        = "Third"
    static var forth        = "Forth"
}

//App Notification observer Names // ex
struct AppNotificationObservers {
    static var observerForHomeScreenCountDownBanner = "observerForHomeScreenCountDownBanner"
}


//In App Purchase PurchaseID // ex
struct AppInAppPurchaseProductIds{
    static var oneMonthlyProductId              = "com.sleepsounds.app.1month"
}


//App Alert messages
struct AppAlertMessages {
    static var message_ForInternetConnectionLost = "You need internet. Come back when you have got it 🙂"
    static var message_InternetNotAvailable = "Internet connection is not available. Please check your internet connection and try again."
    static var message_SomethingWrong = "Oops.. Something went wrong !!"
    static var message_LocationServiceStart  = "You have to enable the Location Service to use this App. To enable, please go to Settings >> Privacy >> Location Services"
    static var message_LocationServiceDisabled = "You currently have all location services for this device disabled"
    static var message_ChangePasswordSuccess = "password change successfully"
    static var message_ForgotPasswordSuccess = "Please check you mail for new password"
    static var message_NewPasswordNotMatch = "Newpassword and ConfirmPassword is not match"
    static var message_Nodatatext = "No data available"
    static var message_Trums = "I hereby confirm that I read the privacy policy thoroughly and agree to it."
    static var message_PrivacyPolicyCheck  = "You must agree privacy policy before signup."
    static var message_VerificationCheck  = "Verification code not match."
    static var message_Glucose  = "Enter your blood glucose value."
    
}

//App Text, messages
struct AppText {
    static var text_ForgotScreenTitle = "Forgot Your Password"
    static var text_ForgotScreenInfoText = "Enter your email address and we'll send you a link to reset your password"
}





//Core Data TableName // ex
struct AppTableName {
    
    static var tblEntityMergeSounds            = "EntityMergeSounds"
    struct tblEntityMergeSoundsColumnNames {
        static var MergeSoundId                   = "mergeSoundId"
        static var MergeSoundName                 = "mergeSoundName"
        static var MergeSoundPath                 = "mergeSoundPath"
        static var MergeSoundCreatedDateTimeStamp = "mergeSoundCreatedDateTimeStamp"
    }
    
    static var tblEntitySingleSoundForAlarm            = "EntitySingleSoundForAlarm"
    struct tblEntitySingleSoundForAlarmColumnNames {
        static var SingleSoundID                   = "singleSoundID"
        static var SingleSoundName                 = "singleSoundName"
        static var SingleSoundPath                 = "singleSoundPath"
        static var SingleSoundCreatedDateTimeStamp = "singleSoundCreatedDate"
    }
}


// MARK: PlaceHolder Imges Name and UIImages
struct AppImages {
    static var  placeHolderUserImageName              = "profile"
    static var  placeHolderThumbImageName             = "placeholder_inventory_thumb"
    static var  placeHolderLargeImageName             = "placeholder_inventory_main"
    static var  placeHolderMissionImageName           = "placeholder"
    static var  placeHolderUser                        = ImageNamed(name:AppImages.placeHolderUserImageName)
    static var  placeHolderMission                     = ImageNamed(name:AppImages.placeHolderThumbImageName)
    static var  placeHolderThumb                       = ImageNamed(name:AppImages.placeHolderMissionImageName)
}


// MARK: App IDS,Client IDs,Keys,productIds
struct AppIds{
    static var  AppStoreId      = "1217345846"  // App Store ID
    static var  AdMobID         = "ca-app-pub-5763547652932018/8077300881"  // Ad Mob ID
    static var  FlurryID        = "SSHS9KG8P6MFK76RJC62"  // Flurry ID
    static var  payPalClientIDProduction    = "ATa_UibxxmenriQY24RFaz7LJWHpgEgKoo68jQd2NWIjKB2x7Vfiqr7TCD4TLvD1sULNvCjWQ6ZRup-4"
    static var  payPalClientIDSendbox       = "AduzWXjxVbq1hDd9jOxm44-S1C8i6zP9r3IxzWuUJOFRURtct0sKbP40ZPERvDJhNROJln5Dbtx7Euxt"
    static var  urlSchemeFacebook           = "fb720817031436036"
    static var  urlScheme_Google             = "com.googleusercontent.apps.284136343521-3vtits51co1rqvu8gfpd8kloeadipuqm"
}


// MARK: App Data
struct AppData{
    static var  AppName             = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String // App Name
    static var  AppBundleVersion    = Bundle.main.infoDictionary?["CFBundleVersion"] as! String // App Bundle number
    static var  AppVersion          = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject  // App Version
    static var  deviceModelName     = UIDevice.current.description  // Device Model Name
    static var  deviceVersionOS     = UIDevice.current.systemVersion  // Device Version Number
}


struct AppKeys {
    static var keyDeviceToken                   = "deviceToken"
    static var keyLoggedIn                      = "keyLoggedIn"
    static var keyWalkthroughFinish             = "keyWalkthrough"
    static var keyRecomendSelected              = "keyRecomendSelected"
    static var keyHeartSelected                 = "heartSelection"
    static var keyLocationSelection             = "locationSelection"
    static var keyIsBreakfast                   = "Breakfast"
    static var keyIsLunch                       = "Lunch"
    static var keyIsDinner                      = "Dinner"
    static var keyBreakfastTime                 = "BreakfastTime"
    static var keyLunchTime                     = "LunchTime"
    static var keyDinnerTime                    = "DinnerTime"
    static var keyIsSuggestedReminders          = "isSuggestedReminders"
    static var keyLet                           = "keyLet"
    static var keyLung                          = "keyLung"
    
}





