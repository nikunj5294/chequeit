//
//  Enums.swift
//   
//
//  Created by Govind ravaliya on 9/15/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit

public enum LanguageType {
    case english
    case gujarati
}

public enum LoginTableViewCells: Int {
    case email
    case password
    case login
    case or
    case socialLogin
    
    static var count: Int {
        return LoginTableViewCells.socialLogin.hashValue + 1
    }
}

public enum SignupTableViewCells: Int {
    case name
    case email
    case password
    case confirmPassword
    case signup
    
    static var count: Int {
        return SignupTableViewCells.signup.hashValue + 1
    }
}

public enum popupScreen : Int{
    case login = 0
    case signUP = 1
    case forgotPassword = 2
    case quoteRequest = 3
    case createInvoice = 4
    case stripePayment = 5
}

