//
//  dashboardViewController.swift
//  Skilli
//
//  Created by Govind ravaliya on 19/10/17.
//  Copyright © 2017 Govind Ravaliya.ShareAd. All rights reserved.
//

import UIKit


class LoginViewController: BaseViewController {
    
    // MARK:- OUTLETS
    
    
    @IBOutlet var textUserName: CHTextFieldLine!
    @IBOutlet var textPassword: CHTextFieldLine!
    @IBOutlet var buttonLogin: CHButtonRounded!
    @IBOutlet var buttonSignUp: CHButtonBold!
    @IBOutlet var buttonForgotPassword: CHButton!
    @IBOutlet weak var buttonFbLogin: CHButtonBold!
    
    // MARK:- PROPERTIES
    
    
    
    
    // MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.doSetupUI()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK:- UI SETUP
    func doSetupUI() {
        
        // Set Color
        self.buttonLogin.backgroundColor = UIColor.AppColor.colorWhite
        self.buttonLogin.tintColor = UIColor.AppColor.colorRed
        self.buttonSignUp.backgroundColor = UIColor.AppColor.colorClear
        self.buttonSignUp.tintColor = UIColor.AppColor.colorAppOrange
        self.buttonForgotPassword.backgroundColor = UIColor.AppColor.colorClear
        self.buttonForgotPassword.tintColor = UIColor.AppColor.colorWhite
        self.buttonFbLogin.applyCornerRadius(radius: self.buttonFbLogin.frame.height/2)
        
        //
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    
   
    
    // MARK:- BUTTON EVENTS

    @IBAction func buttonLogin_Click(_ sender: Any) {
        
        setUserDefaultsFor(object: true as AnyObject, with: AppKeys.keyLoggedIn)
        setUserDefaultsFor(object: false as AnyObject, with: AppKeys.keyWalkthroughFinish)
        
//        userPreferences.set(true, forKey:UserPreferences.AppUserDefaultKeys.keyLoggedIn)
//        userPreferences.set(false, forKey:UserPreferences.AppUserDefaultKeys.keyWalkthroughFinish)
        //pushTo("manageProfileViewController")
        pushTo("firstWalkViewController")
        
    
    }
    
    @IBAction func buttonSignUp_Clcik(_ sender: Any) {
        
        self.pushTo("signUpViewController")
    
    }
    @IBAction func buttonForgotPassword_Clcik(_ sender: Any) {
    
    }
    
    
    
}

