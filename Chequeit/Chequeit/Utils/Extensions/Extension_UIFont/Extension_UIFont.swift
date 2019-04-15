//
//  Extension_UIFont.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import Foundation
import UIKit

extension UIFont {
	
    //  // Gill Sans
    
    //App Tab Names
    struct AppFontType {
        static var quicksandBold                    = "Quicksand-Bold"
        static var quicksandLight                   = "Quicksand-Light"
        static var quicksandRegular                 = "Quicksand-Regular"

    }
    
	// SYSTEM REGULAR
	class func appFont_Regular(fontSize : CGFloat) -> UIFont {
        return UIFont(name: AppFontType.quicksandRegular, size: fontSize)!
  //      return UIFont.systemFont(ofSize:fontSize)
	}

	// SYSTEM BOLD
	class func appFont_Bold(fontSize : CGFloat) -> UIFont {
        return UIFont(name: AppFontType.quicksandBold, size: fontSize)!
//        return UIFont.boldSystemFont(ofSize:fontSize)
    }
    
    // SYSTEM ITALIK
    class func appFont_Italic(fontSize : CGFloat) -> UIFont {
        return UIFont(name: AppFontType.quicksandLight, size: fontSize)!
//        return UIFont.italicSystemFont(ofSize:fontSize)
    }

    
    

}
