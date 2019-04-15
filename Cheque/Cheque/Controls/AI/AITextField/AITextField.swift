//
//  AITextField.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit



class AITextField: UITextField {
	
	
	//MARK:- PROPERTIES
	
	var shouldPreventAllActions:Bool = false
	var canCut:Bool = true
	var canCopy:Bool = true
	var canPaste:Bool = true
	var canSelect:Bool = true
	var canSelectAll:Bool = true

	var needToLayoutSubviews:Bool = true
	
	
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
	
	func commonInit(){
		
		self.borderStyle = .none
		
		self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
		self.tintColor =  UIColor.AppColor.colorBlack
		
		if(self.placeholder != nil ){
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes:[NSAttributedStringKey.foregroundColor: UIColor.AppColor.colorAppGray])
		}
		self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
		self.leftViewMode = .always
		
		self.autocorrectionType = .no
	}

	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if self.needToLayoutSubviews {
			self.addBorderWithColor(color: UIColor.AppColor.colorAppGray, edge: AIEdge.Bottom, thicknessOfBorder: 1)
			self.needToLayoutSubviews = false
		}
	}

	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		
		if(self.shouldPreventAllActions){
			return false
		}
		
		switch action {
		case #selector(UIResponderStandardEditActions.cut(_:)):
			return self.canCut ? super.canPerformAction(action, withSender: sender) : self.canCut
		case #selector(UIResponderStandardEditActions.copy(_:)):
			return self.canCopy ? super.canPerformAction(action, withSender: sender) : self.canCopy
		case #selector(UIResponderStandardEditActions.paste(_:)):
			return self.canPaste ? super.canPerformAction(action, withSender: sender) : self.canPaste
		case #selector(UIResponderStandardEditActions.select(_:)):
			return self.canSelect ? super.canPerformAction(action, withSender: sender) : self.canSelect
		case #selector(UIResponderStandardEditActions.selectAll(_:)):
			return self.canSelectAll ? super.canPerformAction(action, withSender: sender) : self.canSelectAll
		default:
			return super.canPerformAction(action, withSender: sender)
		}
	}
}


class AITextFieldNormal: UITextField {
	
	
	//MARK:- PROPERTIES
	
	var shouldPreventAllActions:Bool = false
	var canCut:Bool = true
	var canCopy:Bool = true
	var canPaste:Bool = true
	var canSelect:Bool = true
	var canSelectAll:Bool = true
	
	var needToLayoutSubviews:Bool = true
	
	
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
	
	func commonInit(){
		
		self.borderStyle = .none
		
		self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
		self.tintColor = UIColor.AppColor.colorBlack
		
		if(self.placeholder != nil ){
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes:[NSAttributedStringKey.foregroundColor: UIColor.AppColor.colorAppGray])
		}
		
		self.autocorrectionType = .no

	}
	
	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		
		if(self.shouldPreventAllActions){
			return false
		}
		
		switch action {
		case #selector(UIResponderStandardEditActions.cut(_:)):
			return self.canCut ? super.canPerformAction(action, withSender: sender) : self.canCut
		case #selector(UIResponderStandardEditActions.copy(_:)):
			return self.canCopy ? super.canPerformAction(action, withSender: sender) : self.canCopy
		case #selector(UIResponderStandardEditActions.paste(_:)):
			return self.canPaste ? super.canPerformAction(action, withSender: sender) : self.canPaste
		case #selector(UIResponderStandardEditActions.select(_:)):
			return self.canSelect ? super.canPerformAction(action, withSender: sender) : self.canSelect
		case #selector(UIResponderStandardEditActions.selectAll(_:)):
			return self.canSelectAll ? super.canPerformAction(action, withSender: sender) : self.canSelectAll
		default:
			return super.canPerformAction(action, withSender: sender)
		}
	}
}

class AITextFieldNormalBold: UITextField {
	
	
	//MARK:- PROPERTIES
	
	var shouldPreventAllActions:Bool = false
	var canCut:Bool = true
	var canCopy:Bool = true
	var canPaste:Bool = true
	var canSelect:Bool = true
	var canSelectAll:Bool = true
	
	var needToLayoutSubviews:Bool = true
	
	
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
	
	func commonInit(){
		
		self.borderStyle = .none
		
		self.font = UIFont.appFont_Bold(fontSize: self.font!.pointSize.proportionalFontSize())
		self.tintColor = UIColor.AppColor.colorBlack
		
		if(self.placeholder != nil ){
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes:[NSAttributedStringKey.foregroundColor: UIColor.AppColor.colorAppGray])
		}
		
		self.autocorrectionType = .no
		
	}
	
	override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
		
		if(self.shouldPreventAllActions){
			return false
		}
		
		switch action {
		case #selector(UIResponderStandardEditActions.cut(_:)):
			return self.canCut ? super.canPerformAction(action, withSender: sender) : self.canCut
		case #selector(UIResponderStandardEditActions.copy(_:)):
			return self.canCopy ? super.canPerformAction(action, withSender: sender) : self.canCopy
		case #selector(UIResponderStandardEditActions.paste(_:)):
			return self.canPaste ? super.canPerformAction(action, withSender: sender) : self.canPaste
		case #selector(UIResponderStandardEditActions.select(_:)):
			return self.canSelect ? super.canPerformAction(action, withSender: sender) : self.canSelect
		case #selector(UIResponderStandardEditActions.selectAll(_:)):
			return self.canSelectAll ? super.canPerformAction(action, withSender: sender) : self.canSelectAll
		default:
			return super.canPerformAction(action, withSender: sender)
		}
	}
}
