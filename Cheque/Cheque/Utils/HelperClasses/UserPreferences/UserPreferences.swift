//
//  UserDefaults.swift
//   
//
//  Created by Govind ravaliya on 9/18/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit


let userPreferences = UserPreferences.shared


class UserPreferences: NSObject {
    
    //MARK: Shared Instance
    static let shared : UserPreferences = UserPreferences()
    
    //App userDefault keys used
    

    func set(_ value: Any?, forKey: String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    func getValue(forKey: String) -> Any? {
       return UserDefaults.standard.value(forKey: forKey)
    }
    
    func remove(forKey: String){
        UserDefaults.standard.removeObject(forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
}
