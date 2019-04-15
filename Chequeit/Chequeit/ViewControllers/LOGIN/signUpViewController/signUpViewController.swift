//
//  dashboardViewController.swift
//  Skilli
//
//  Created by Govind ravaliya on 19/10/17.
//  Copyright © 2017 Govind Ravaliya.ShareAd. All rights reserved.
//

import UIKit

class signUpViewController: BaseViewController {
    
    // MARK:- OUTLETS
    
    
    @IBOutlet var imageViewUserSelectedImage: UIImageView!
    @IBOutlet var textPassword: CHTextFieldLine!
    @IBOutlet var textEmailAddress: CHTextFieldLine!
    @IBOutlet var textName: CHTextFieldLine!
    @IBOutlet var buttonCreate: CHButtonRounded!
    @IBOutlet var buttonSignIn: CHButtonBold!
    
    
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
        self.view.backgroundColor = UIColor.AppColor.colorAppGreen
        self.buttonCreate.backgroundColor = UIColor.AppColor.colorWhite
        self.buttonCreate.tintColor = UIColor.AppColor.colorAppGreen
        self.buttonSignIn.backgroundColor = UIColor.AppColor.colorClear
        self.buttonSignIn.tintColor = UIColor.AppColor.colorWhite
    
        
    }
    
    
    // MARK:- BUTTON EVENTS

    @IBAction func buttonSelectPhoto_Click(_ sender: Any) {
        
        
    }
    
    @IBAction func buttonSignin_Click(_ sender: Any) {
    
        self.popTo()
        
    }
    @IBAction func buttonSignUp_Click(_ sender: Any) {
        
        setUserDefaultsFor(object: true as AnyObject, with: AppKeys.keyLoggedIn)
        setUserDefaultsFor(object: false as AnyObject, with: AppKeys.keyWalkthroughFinish)
        
//        userPreferences.set(true, forKey:UserPreferences.AppUserDefaultKeys.keyLoggedIn)
//        userPreferences.set(false, forKey:UserPreferences.AppUserDefaultKeys.keyWalkthroughFinish)
        
        //pushTo("manageProfileViewController")
        pushTo("firstWalkViewController")
        
        
    }
    
    
}
