//
//  BaseViewController.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit



class tabViewController: UITabBarController {

    
	// MARK:- VIEW LIFE CYCLE
	override func viewDidLoad()	{
		
		super.viewDidLoad()
	    
        // SETUP BASE UI
		
        
		
	}
	
	//MARK:-
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
        
        self.tabBar.barTintColor = UIColor.AppColor.colorAppGreen
        
        self.setAppearanceOfTabBar()
        
        
        
        self.tabBar.setValue(true, forKey: "_hidesShadow")
        self.tabBar.shadowImage = UIImage(named: "signup_logo")
        
    }
    
    func hideBottomHairline() {
        /*
         Hide line under navigation bar
         */
    
    }
    func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		
	

	}
	

	//MARK:-
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	

	
    
}



