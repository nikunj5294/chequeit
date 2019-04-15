//
//  UIAlertControllerExtension.swift
//   
//
//  Created by Govind ravaliya on 9/14/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func showNoInternetConnectionAlert() {
        let alertController = UIAlertController(title: Constants.AppName, message: Constants.noInternetConnectionMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.okay, style: .default, handler: nil))
        Constants.appDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(withMessage message: String, buttonTitles: [String] = [Constants.okay], buttonAction: AlertControllerButtonActionHandler?) {
        let alertController = UIAlertController(title: Constants.AppName, message: message, preferredStyle: .alert)
        
        for btn in buttonTitles {
            alertController.addAction(UIAlertAction(title: btn, style: .default, handler: { (action) in
                if let validHandler = buttonAction {
                    validHandler(buttonTitles.index(of: btn)!)
                }
            }))
        }
        
        Constant.appDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

