//
//  Extension_UIColor.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import Foundation
import UIKit

extension UIColor {
	
    convenience init(red: Int, green: Int, blue: Int, alpha:Float) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(netHex:Int) {
		self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, alpha:1)
	}
    
    // RGB SORTCUT
    class func RGB( _ R:CGFloat, _ G:CGFloat, _ B:CGFloat, _ A:CGFloat) -> UIColor {
        return self.init(red: R/255, green:G/255, blue:B/255, alpha:A)
    }
    
    // ALL APP COLORS
    struct AppColor {
        static var colorClear                       = UIColor.clear
        static var colorWhite                       = UIColor.white
        static var colorBlack                       = UIColor.black
        static var colorRed                         = UIColor.red
        static var colorDarkGray                    = UIColor.darkGray
        static var colorLightGray                   = UIColor.lightGray
        static var colorGreen                       = UIColor.green
        static var colorStatusBar                   = UIColor.RGB(0, 0, 0, 1.0)
        
        static var colorNavigationBar               = UIColor.RGB(166, 216, 3, 1)
        static var colorNavigationBarButton         = UIColor.RGB(0, 0, 0, 1)
        static var colorNavigationBarSeparator      = UIColor.RGB(77, 77, 77, 1)
        static var colorTabBar                      = UIColor.RGB(166, 216, 3, 1)
        static var colorTabBarSelectedButton        = UIColor.white
        static var colorTabBarUnSelectedButton      = UIColor.lightGray
        
        
        static var colorAppGreen                    = UIColor.RGB(142, 197, 64, 1)
        
        static var colorAppOrange                    = UIColor.RGB(246, 150, 33, 1)
        static var colorAppRedColor                 = UIColor.RGB(242, 224, 33, 1)
        static var colorAppLightWhite               = UIColor.RGB(255, 255, 255, 0.5)
        static var colorLightBlue                   = UIColor.RGB(225, 239, 252, 1)
     
        static var colorAppGray                     = UIColor.RGB(117, 117, 117, 1)
        static var colorAppLightGray                = UIColor.RGB(239, 239, 239, 1)
        static var colorAppCellBackgroundGray       = UIColor.RGB(243, 243, 243, 1)
        static var colorAppTextLightGray            = UIColor.RGB(115, 115, 115, 1)
        static var colorAppSepraterGray             = UIColor.RGB(224, 224, 224, 1)
        static var colorLightBlack                  = UIColor.RGB(0, 0, 0, 0.3)
       
    }
  
}
