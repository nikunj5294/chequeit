//
//  ConstantsAndKeys.swift
//   
//
//  Created by Govind ravaliya on 9/14/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import Foundation

// MARK: Internet connection lost Alert Messages
class Constants {
    class var noInternetConnectionMessage : String {
        return "Internet connection not available. Please check your internet connection."
    }
    
    class var somethingWentWrongMessage : String {
        return "Something went wrong. Please try again later."
    }
    
    class var AppName : String {
        return Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    }
    
    class var okay: String {
        return "Okay"
    }
    
    class var cancel: String {
        return "Cancel"
    }
}
