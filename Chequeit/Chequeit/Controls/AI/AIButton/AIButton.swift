//
//  AIButton.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit

class AIButton: UIButton {

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
	}
	
    func animateSelectedStateWithAnimation(WithSameEffectOnStateChange sameEffectOnStateChange:Bool, OnCompletion completion: @escaping () -> Void){
		
		// TO DISABLE QUICK NEW ANIMATION UNTIL PREVIOUS ONE COMPLETES
		self.isUserInteractionEnabled = false
		
		if(self.isSelected){
			
			UIView.transition(with: self, duration: 0.3, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
				self.isSelected = !self.isSelected
				
			}, completion: { (ss) in
				self.isUserInteractionEnabled = true
				completion()
			})
			return
		}
		
		if(sameEffectOnStateChange){
			
			UIView.transition(with: self, duration: 0.3, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
				self.isSelected = !self.isSelected
				
			}, completion: { (ss) in
				self.isUserInteractionEnabled = true
				completion()
			})
			return
		}
		
		UIView.animate(withDuration: 0.2 ,
		                           animations: {
									self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		},
		                           completion: { finish in
									
									UIView.animate(withDuration: 0.2 ,
									                           animations: {
																self.isSelected = !self.isSelected
																self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
									},
									                           completion: { finish in
																
																
																UIView.animate(withDuration: 0.2 ,
																                           animations: {
																							self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
																},
																                           completion: { finish in
																							UIView.animate(withDuration: 0.2){
																								self.transform = CGAffineTransform.identity
																								self.isUserInteractionEnabled = true
																								completion()
																							}
																})
									})
		})
	}
	
	
	
    func animateSelectedStateWithAnimationOnCompletion(completion: @escaping () -> Void){
		
		// TO DISABLE QUICK NEW ANIMATION UNTIL PREVIOUS ONE COMPLETES
		self.isUserInteractionEnabled = false
		
		if(self.isSelected){
			
			UIView.transition(with: self, duration: 0.3, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
				self.isSelected = !self.isSelected
				
			}, completion: { (ss) in
				self.isUserInteractionEnabled = true
				completion()
			})
			return
		}
		
		
		UIView.animate(withDuration: 0.2 ,
		                           animations: {
									self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		},
		                           completion: { finish in
									
									UIView.animate(withDuration: 0.2 ,
									                           animations: {
																self.isSelected = !self.isSelected
																self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
									},
									                           completion: { finish in
																
																
																UIView.animate(withDuration: 0.2 ,
																                           animations: {
																							self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
																},
																                           completion: { finish in
																							UIView.animate(withDuration: 0.2){
																								self.transform = CGAffineTransform.identity
																								self.isUserInteractionEnabled = true
																								completion()
																							}
																})
									})
		})
		
	}

}


class AIButtonBold: UIButton {
	
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

class AIButtonlItalic: UIButton {
    
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
        self.titleLabel!.font = UIFont.appFont_Italic(fontSize: self.titleLabel!.font.pointSize.proportionalFontSize())
        self.isExclusiveTouch = true
    }
}



class AIButtonPickerItem:NSObject {
	
	var itemName:String = ""
	var isSelected:Bool = false
	
	override init() {
		
	}
	
	init(withName name:String) {
		self.itemName = name
	}
}


class AIButtonPicker: UIButton, UIPickerViewDataSource, UIPickerViewDelegate
{
	var pickerView:UIPickerView?
	var toolBarForInputAccessoryView:UIToolbar?
	var arrDataSource:[AIButtonPickerItem] = []
	var arrDataSource1:[AIButtonPickerItem] = []
	
	var btnCancel: AIButton = AIButton()
	
	var btnPressHandler: ((_ sender:AIButtonPicker) -> (Void))?
	var cancelHandler: ((_ sender:AIButtonPicker) -> (Void))?
	var doneHandler: ((_ sender:AIButtonPicker) -> (Void))?
	var dateValueChangeHandler: ((_ sender:AIButtonPicker) -> (Void))?
	
	var viewTransparent:UIView?
	
	// MARK: - INIT
	override func awakeFromNib() {
		super.awakeFromNib()
		self.isExclusiveTouch = true
		self.doSetupInputView()
		self.backgroundColor = UIColor.clear
	}
	
	
	// MARK:- OVERRIDING
	override var inputView: UIView? {
		get {
			return self.pickerView
		}
		set {
			self.inputView = self.pickerView
		}
	}
	
	override var inputAccessoryView: UIView? {
		get {
			return self.toolBarForInputAccessoryView
		}
		set {
			self.inputAccessoryView = self.toolBarForInputAccessoryView
		}
	}


    override var canBecomeFirstResponder: Bool {
		return true
	}
	
	// MARK:- SETUP INPUT AND ACCESSORY VIEWS
	func doSetupInputView()
	{
		// UIPICKERVIEW
		
		self.pickerView = UIPickerView()
		self.pickerView!.backgroundColor = UIColor.white
		self.pickerView?.dataSource = self
		self.pickerView?.delegate = self
		
		// TOOLBAR ITEMS
		
		btnCancel.setTitle("Cancel", for: .normal)
		btnCancel.setTitleColor(UIColor.AppColor.colorGreen, for: .normal)
		btnCancel.addTarget(self, action: #selector(self.btnCancelHandler(sender:)), for: .touchUpInside)
		btnCancel.sizeToFit()
		
		let btnDone: AIButton = AIButton()
		btnDone.setTitle("Done", for: .normal)
		btnDone.setTitleColor(UIColor.AppColor.colorGreen, for: .normal)
		btnDone.addTarget(self, action: #selector(self.btnDoneHandler(sender:)), for: .touchUpInside)
		btnDone.sizeToFit()
		
		let barBtnCancel: UIBarButtonItem = UIBarButtonItem.init(customView: btnCancel)
		let barBtnDone: UIBarButtonItem = UIBarButtonItem.init(customView: btnDone)
		let barBtnFlexibleSpace: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		
		// TOOLBAR
		self.toolBarForInputAccessoryView = UIToolbar()
		self.toolBarForInputAccessoryView!.frame = CGRect(x: 0, y: 0, width: Devices.screenWidth, height: 44)
		self.toolBarForInputAccessoryView!.barTintColor = UIColor.AppColor.colorWhite
		self.toolBarForInputAccessoryView!.isTranslucent = true
		self.toolBarForInputAccessoryView!.items = [barBtnCancel,barBtnFlexibleSpace,barBtnDone]
		
		// ADDING TARGET
		
		self.addTarget(self, action: #selector(self.btnTapHandler(sender:)), for: .touchUpInside)
	}
	
	
	// MARK: - PICKERVIEW DELEGATE
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return self.arrDataSource1.count == 0 ? 1 : 2
	}
	
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		//		return self.arrDataSource.count
		
		var rowsToReturn:Int = 0
		if(self.arrDataSource1.count == 0){
			rowsToReturn = self.arrDataSource.count
		}else{
			switch component {
			case 0:
				rowsToReturn = self.arrDataSource.count
			case 1:
				rowsToReturn = self.arrDataSource1.count
			default:
				break
			}
		}
		return rowsToReturn
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		
		let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: Devices.screenWidth, height: 30))
		lblTitle.textAlignment = .center
		lblTitle.textColor = UIColor.AppColor.colorBlack
		lblTitle.font = UIFont.appFont_Regular(fontSize: CGFloat(18).proportionalFontSize())
		//		lblTitle.text = self.arrDataSource[row].itemName
		
		
		var title:String = ""
		if(self.arrDataSource1.count == 0){
			title = self.arrDataSource[row].itemName
		}else{
			switch component {
			case 0:
				title = self.arrDataSource[row].itemName
			case 1:
				title = self.arrDataSource1[row].itemName
			default:
				break
			}
		}
		lblTitle.text = title
		return lblTitle
	}
	
	
	// MARK: - BUTTON HANDLER
	
    @objc func btnTapHandler(sender:UIButton){
		
		self.showTransparentViewBehindKeyboard()
		
		//		self.datePickerView!.datePickerMode = self.datePickerViewMode != nil ? self.datePickerViewMode! : UIDatePickerMode.DateAndTime
		
		
		self.becomeFirstResponder()
		if((self.btnPressHandler) != nil){
			self.btnPressHandler!(self)
		}
	}
	
    @objc func btnCancelHandler(sender:UIButton) {
		
		self.resignFirstResponder()
		self.hideTransparentViewBehindKeyboard()
		
		if((self.cancelHandler) != nil){
			self.cancelHandler!(self)
		}
	}
    @objc func btnDoneHandler(sender:UIButton) {
		
		self.resignFirstResponder()
		self.hideTransparentViewBehindKeyboard()
		
		if((self.doneHandler) != nil){
			self.doneHandler!(self)
		}
	}
	
	func datePickerValueChangedHandler(sender: UIDatePicker) {
		
		if(self.dateValueChangeHandler != nil){
			self.dateValueChangeHandler!(self)
		}
	}
	
	
	//MARK:- SHOW / HIDE TRANSPARENT VIEW
	
	func showTransparentViewBehindKeyboard() {
		
		self.viewTransparent = UIView(frame: CGRect(x: 0, y: 0, width: Devices.screenWidth, height: Devices.screenHeight))
		self.viewTransparent!.backgroundColor = UIColor.AppColor.colorBlack
		appDelegate.window?.addSubview(viewTransparent!)
		self.viewTransparent?.alpha = 0
		
		UIView.animate(withDuration: 0.3) {
			self.viewTransparent?.alpha = 0.2
		}
	}
	
	func hideTransparentViewBehindKeyboard() {
		
		UIView.animate(withDuration: 0.3, animations: {
			self.viewTransparent?.alpha = 0
		}) { (bbb) in
			self.viewTransparent?.removeFromSuperview()
		}
	}
	
}
