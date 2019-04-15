//
//  UIDeviceExtension.swift
//   
//
//  Created by Govind ravaliya on 9/14/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit

extension UIDevice {
    
    static var isPortrait : Bool {
        return UIDevice.current.orientation.isPortrait
    }
    
    static var isLandscape : Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
   
}
