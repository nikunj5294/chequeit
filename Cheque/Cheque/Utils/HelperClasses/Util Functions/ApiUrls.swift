//
//  ApiUrls.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import Foundation


// MARK:- WEB LINKS: T&C,PRIVACY,APPSTORE
struct AppWebLink {
    static var  termsConditionsLink         = "http://180.211.99.165/rs/LLENA/about/terms.html"
    static var  privacyPolicyLink           = "http://180.211.99.165/rs/LLENA/about/privacy.html"
    static var  facebookLink                = "https://www.facebook.com/"
    static var  instagram                   = "https://www.instagram.com/asr3_delivery"
    static var  twitterLink                 = "https://twitter.com/ASR3_Delivery"
    static var  appStoreLink                = "https://itunes.apple.com/app/id1170475170"
}


// MARK:- App BaseURlS
struct AppUrl {
    static var  urlBase                   = "http://180.211.99.165:8080/~/api/v2/api/"
    static var  urlMission                = "http://180.211.99.165:8080/~/api/assets/mission_images/"
    static var  urlUser                   = "http://180.211.99.165:8080/~/api/assets/user_images/"
    static var  urlInventory              = "http://180.211.99.165:8080/~/api/assets/inventory_images/"
    static var  urlQRCode                = "http://180.211.99.165:8080/~/api/assets/qrcode_images/"
}


// MARK:- Api EndPoints,CMD Points
struct endPoint {
    static var  urlLogin                    = "login"
    static var  urlLoginFacebook            = "login_with_facebook"
    static var  urlGoogle                   = "login_with_google"
    static var  urlSignUp                   = "signup"
    static var  urlForgotPssword            = "sendForgotpassword_link"
    static var  urlChangePssword            = "changePassword"
    static var  urlLogot                    = "logout"
    static var  urlList                     = "list_all_mission"
}


func getUrl(_ endPoint:String) -> String {
	return AppUrl.urlBase + endPoint
}




