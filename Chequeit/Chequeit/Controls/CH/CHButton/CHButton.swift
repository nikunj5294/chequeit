//
//  AIButton.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit

class CHButton: AIButton {

	//MARK:- INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		commonInit()
	}
	
	private func commonInit(){
        self.titleLabel!.font = UIFont.appFont_Bold(fontSize: self.titleLabel!.font.pointSize.proportionalFontSize())
		self.isExclusiveTouch = true
	}
   
}
class CHButtonBold: AIButtonBold {
    
    //MARK:- INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit(){
        self.titleLabel!.font = UIFont.appFont_Bold(fontSize: self.titleLabel!.font.pointSize.proportionalFontSize())
        self.isExclusiveTouch = true
    }
}


class CHButtonItalic: AIButtonlItalic {
    
    //MARK:- INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit(){
       // self.titleLabel!.font = UIFont.appFont_Bold(fontSize: self.titleLabel!.font.pointSize.proportionalFontSize())
        self.isExclusiveTouch = true
    }
}


class CHButtonRounded: AIButton {
    
    //MARK:- INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit(){
        self.titleLabel!.font = UIFont.appFont_Regular(fontSize: self.titleLabel!.font.pointSize.proportionalFontSize())
        self.isExclusiveTouch = true
        self.applyCornerRadius(radius: self.frame.height/2)
    //    self.backgroundColor = UIColor.AppColor.colorWhite
     }
}





class CHButtonPickerItem:AIButtonPickerItem {
	
//    override init(withName name:String) {
//        super.itemName = name
//    }
}


class CHButtonPicker: AIButtonPicker
{
	// MARK: - INIT
	override func awakeFromNib() {
		super.awakeFromNib()
		self.isExclusiveTouch = true
		self.doSetupInputView()
		self.backgroundColor = UIColor.clear
	}

}
