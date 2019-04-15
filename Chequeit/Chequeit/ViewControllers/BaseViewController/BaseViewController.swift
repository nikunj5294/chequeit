//
//  BaseViewController.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit
import MapKit


//MARK:- AILeftBarButtonType
enum AILeftBarButtonType: Int {
	
	case
	backArrow,
	cross,
	dismiss,
	none
	
	var imageName: String {
		switch self {
		case .backArrow:
			return "back"
		case .cross:
			return "close"
		case .dismiss:
			return "close"
		case .none:
			return ""
		}
	}
}

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {

    
     // MARK:- OUTLETS
    @IBOutlet weak fileprivate var viewTitleBackground:  UIView!
  
    
	// MARK:- PROPERTIES
	var backButtonType: AILeftBarButtonType = AILeftBarButtonType.backArrow
	var shouldPreventInteractivePopGesture:Bool = false
	var shouldHideNavigationBar:Bool = false
    var viewTitle:  CKViewTop!
   
    
	
	// MARK:- VIEW LIFE CYCLE
	override func viewDidLoad()	{
		
		super.viewDidLoad()
	    
        // SETUP BASE UI
		self.doSetupBaseUI()
		
        
		
	}
	
	//MARK:-
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
        // HIDING TABBAR FOR PUSED VC
        if(self.backButtonType == .backArrow || self.backButtonType == .cross ){
            //appDelegate.tabBarApp?.hideTabbarWithAddButton()
        }

        // HIDING NAVIGATION BAR
//        if self.shouldHideNavigationBar {
//            //self.navigationController?.isNavigationBarHidden = true
//        }
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		
		// CLOSING KEYBOARD ON EXITING FROM VC
		self.view.endEditing(true)
		
		// SHOWING TABBAR FOR PUSED VC
		if(self.backButtonType == .backArrow || self.backButtonType == .cross){
			//appDelegate.tabBarApp?.showTabbarWithAddButton()
		}
		
		// SHOWING NAVIGATION BAR
		if self.shouldHideNavigationBar {
			//self.navigationController?.isNavigationBarHidden = false
		}

	}
	

	//MARK:-
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.navigationController?.interactivePopGestureRecognizer?.delegate = self
	}
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	
	// MARK:- UI SETUP
	func doSetupBaseUI() {
		
        self.setAppearanceOfNavigationBar()
        self.setAppearanceOfTabBar()
	}
    
    func setTitle(title:String){
        
        // AddTitleView
        
        self.viewTitle = CKViewTop()
        self.viewTitleBackground.addSubview(self.viewTitle)
        self.viewTitle.setupTitleText(title: title)
    }
    func updateTitle(title:String){
        
        // updateTitle
        self.viewTitle.setupTitleText(title: title)
       
    }
	
    
}



extension BaseViewController {
	
	
	
}
