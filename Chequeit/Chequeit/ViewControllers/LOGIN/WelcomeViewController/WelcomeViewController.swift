//
//  dashboardViewController.swift
//  Skilli
//
//  Created by Govind ravaliya on 19/10/17.
//  Copyright © 2017 Govind Ravaliya.ShareAd. All rights reserved.
//

import UIKit


class WelcomeViewController: BaseViewController {
    
    // MARK:- OUTLETS
    @IBOutlet weak var buttonNext: CHButton!
    @IBOutlet weak var buttonBack: CHButton!
    
    // MARK:- PROPERTIES
    
    @IBOutlet weak var labrlWelcome: CHLabelBold!
    
    
    
    // MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.doSetupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK:- UI SETUP
    func doSetupUI() {
        
        // Set Color
        self.view.backgroundColor = UIColor.AppColor.colorAppGreen
        self.buttonNext.applyCircle()
        self.buttonBack.applyCircle()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.labrlWelcome.setThreeTypeText(s1: "Welcome to LLENA \n\n", s2: "Where ", s3: "Artificial Intelligence ", s4: "Meets ", s5: "Glycemic Index ", s6: "to help you manage and prevent ", s7: "Type 2 Diabetes ", s8: "and ", s9: "Heart Disease ", s10: "with healthy eating choices at your fingertips")
        
    }
    
    
    
    
    // MARK:- BUTTON EVENTS
    
    @IBAction func buttonNext_Click(_ sender: Any) {
        
        pushTo("LoginViewController")
        
    }
    
    @IBAction func buttonBack_Click(_ sender: Any) {
        
        popTo()
    }
    
    
    
    
    
    
}

