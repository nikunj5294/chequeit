//
//  AIViewPlaceHolder.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit
//import PureLayout

class CKViewTop: UIView {
	
	//MARK:- OUTLETS
	@IBOutlet private var contentView:UIView?
    @IBOutlet private var lableTitle: CHLabel?
    @IBOutlet private var viewLine: UIView?
    
    
    // MARK:- INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func commonInit()	{
		
		// LOADING NIB FILE
		Bundle.main.loadNibNamed("CKViewTop", owner: self, options: nil)
		self.addSubview(self.contentView!);
		
		// UI
		self.contentView!.backgroundColor = UIColor.AppColor.colorWhite
        self.lableTitle?.textColor = UIColor.AppColor.colorAppTextLightGray
        self.viewLine?.backgroundColor = UIColor.AppColor.colorAppTextLightGray
        
	}
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if((self.superview) != nil){
			self.frame = CGRect(x: 0, y: 0, width: self.superview!.width, height: self.superview!.height)
			self.contentView?.frame = self.frame
		}
	}
	
	//MARK:- SETUP
    func setupTitleText(title : String)  {
        self.lableTitle?.text =  title
    }
    

}
