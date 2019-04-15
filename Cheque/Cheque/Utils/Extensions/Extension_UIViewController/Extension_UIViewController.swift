//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
import Presentr



extension UIViewController {

    
    
    // MARK:- SideMenu Function
    // MARK:-
    
    var sideMenuViewController: AKSideMenu? {
        get {
            guard var iterator = self.parent else { return nil }
            guard let strClass = String(describing: type(of: iterator)).components(separatedBy: ".").last else { return nil }
            
            while strClass != nibName {
                if iterator is AKSideMenu {
                    return iterator as? AKSideMenu
                } else if iterator.parent != nil && iterator.parent != iterator {
                    iterator = iterator.parent!
                }
            }
            return nil
        }
        set(newValue) {
            self.sideMenuViewController = newValue
        }
    }
    
    
    func setSideViewController(viewControllerName:String) {
        
        self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: viewControllerName)), animated: true)
        //self.sideMenuViewController!.hideMenuViewController()
        
    }
    @IBAction public func presentLeftMenuViewController() {
        self.sideMenuViewController!.presentLeftMenuViewController()
    }
    
    @IBAction public func presentRightMenuViewController() {
        self.sideMenuViewController!.presentRightMenuViewController()
    }
    
   
    // MARK:- TabBar Functions
    // MARK:-
    
    func setAppearanceOfTabBar(){
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = UIColor.AppColor.colorTabBarSelectedButton
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.AppColor.colorAppLightWhite
    }
    
    func removeTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    
    // MARK:- NavigationBar Functions
    // MARK:-
   
    func setAppearanceOfNavigationBar(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.AppColor.colorAppGreen
        self.navigationController?.navigationBar.tintColor = UIColor.AppColor.colorWhite
        self.navigationController?.navigationBar.barTintColor = UIColor.AppColor.colorAppGreen
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.appFont_Regular(fontSize: 18.0) ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : AnyObject]
        
//        let imageViewTitle = UIImageView(image:ImageNamed(name: "skilli_text_navigationBar"))
//        imageViewTitle.contentMode = .scaleAspectFit
//        self.navigationItem.titleView = imageViewTitle
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        self.navigationController?.navigationBar.hideBottomHairline()
    
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow-left")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow-left")
    
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "eeee", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
      
        
        
    }
    func setAppearanceOfNavigationBar2(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.AppColor.colorAppGreen
        self.navigationController?.navigationBar.tintColor = UIColor.AppColor.colorWhite
        self.navigationController?.navigationBar.barTintColor = UIColor.AppColor.colorAppGreen
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.appFont_Regular(fontSize: 18.0) ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : AnyObject]
        
        let imageViewTitle = UIImageView(image:ImageNamed(name: "amazonfresh"))
        
        imageViewTitle.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageViewTitle
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        self.navigationController?.navigationBar.hideBottomHairline()
        
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow-left")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow-left")
    }
    
    func setAppearanceOfNavigationBar3(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.AppColor.colorAppGreen
        self.navigationController?.navigationBar.tintColor = UIColor.AppColor.colorWhite
        self.navigationController?.navigationBar.barTintColor = UIColor.AppColor.colorAppGreen
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.appFont_Regular(fontSize: 18.0) ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : AnyObject]
        
        let imageViewTitle = UIImageView(image:ImageNamed(name: "amazonfresh"))
        imageViewTitle.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageViewTitle
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        self.navigationController?.navigationBar.hideBottomHairline()
        
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow-left")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow-left")
    }
    
    
   
    
    func setAppearanceOfNavigationBar(_ navCont : UINavigationController){
        
        navCont.navigationBar.isTranslucent = false
        navCont.view.backgroundColor = UIColor.clear
        navCont.navigationBar.backgroundColor = UIColor.AppColor.colorRed
        navCont.navigationBar.tintColor = UIColor.white
        navCont.navigationBar.barTintColor =  UIColor.AppColor.colorRed
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont.appFont_Regular(fontSize: 18.0) ]
        navCont.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : AnyObject]
        
        
        
        
        
    }
    
    func setTranslucentOfNavigationBar(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func hideBottomLine() {
        self.navigationController?.navigationBar.hideBottomHairline()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        
    }
    
    //MARK: Add Left NavigationBar Button
    //MARK:-----
    func setLeftBarButtonImage(_ Name : String, selector : Selector) {
        if (self.navigationController != nil) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: Name), style: .plain, target: self, action: selector)
        }
    }
    
    func setLeftBarButtonTitle(_ Name : String, selector : Selector) {
        if (self.navigationController != nil) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title:Name.localized, style: UIBarButtonItemStyle.plain, target: self, action: selector)
           
        }
    }
    
    //MARK: Add Right NavigationBar Button
    //MARK:------
    func setRightBarButtonImage(_ Name : String, selector : Selector) {
        if (self.navigationController != nil) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: Name), style: .plain, target: self, action: selector)
        }
    }
   
    func setTwoRightBarButtonImage(_ btn1Name : String , selector1 : Selector,btn2Name : String , selector2 : Selector) {
        
        if (self.navigationController != nil) {
            
            let btn_1 : UIBarButtonItem =  UIBarButtonItem(image: UIImage(named: btn1Name), style: .plain, target: self, action: selector1)
            let btn_2 : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: btn2Name), style: .plain, target: self, action: selector2)
            let buttons : NSArray = [btn_1, btn_2]
            
            self.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
            
       }
    }
   
    
    func setRightBarButtonTitle(_ Name : String, selector : Selector) {
        
        if (self.navigationController != nil) {
            
             var barButton : UIBarButtonItem = UIBarButtonItem()
            
            barButton = UIBarButtonItem.init(title:Name.localized, style: UIBarButtonItemStyle.plain, target: self, action: selector)
            barButton.setTitleTextAttributes([
                NSAttributedStringKey.font : UIFont.appFont_Regular(fontSize: 18.0),
                NSAttributedStringKey.foregroundColor : UIColor.white,NSAttributedStringKey.backgroundColor:UIColor.clear],
                                             for: UIControlState())
            self.navigationItem.rightBarButtonItem = barButton
        }
    }

    // MARK:- Push,Pop,Present,Dismiss
    
    func pushTo(_ viewController:String) {
        self.navigationController?.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: viewController))!, animated: true)
    }
    
    func popTo() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func presentTo(_ viewController: String) {
        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: viewController)
        let navController = UINavigationController(rootViewController: VC1!)
        self.present(navController, animated:true, completion: nil)
    }
    
    func dismissTo() {
        self.navigationController?.dismiss(animated: true, completion: {
        })
    }
    
    
    
   
    
}
