//
//  Extension_UIButton.swift
//   
//
//  Created by Govind ravaliya on 09/08/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
	
	func makeBold(){
		self.titleLabel?.font = UIFont.appFont_Bold(fontSize: (self.titleLabel?.font.pointSize)!)
		self.setTitleColor(UIColor.AppColor.colorGreen, for: .normal)
	}
	
	func makeRegular(){
		self.titleLabel?.font = UIFont.appFont_Regular(fontSize: (self.titleLabel?.font.pointSize)!)
		self.setTitleColor(UIColor.AppColor.colorBlack, for: .normal)
	}
}
