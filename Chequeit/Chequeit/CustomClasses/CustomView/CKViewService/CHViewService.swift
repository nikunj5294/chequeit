//
//  AIViewPlaceHolder.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit
//import PureLayout

class CHViewService: UIView {
	
	//MARK:- OUTLETS
	@IBOutlet private var contentView:UIView?
  
    @IBOutlet weak var labelCategoryName: CHLabel!
    @IBOutlet weak var labelServiceProvider: CHLabel!
    @IBOutlet weak var labelDetail: CHLabel!
    @IBOutlet weak var labelPrice: CHLabel!
    @IBOutlet var labelHR: CHLabel!
    @IBOutlet weak var viewLine2: UIView!
    @IBOutlet weak var viewLine1: UIView!
    
    
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
		Bundle.main.loadNibNamed("ChViewService", owner: self, options: nil)
		self.addSubview(self.contentView!);
		
		// UI
		self.contentView!.backgroundColor = UIColor.AppColor.colorWhite
        self.labelCategoryName.textColor = UIColor.AppColor.colorAppGreen
        self.labelServiceProvider.textColor = UIColor.AppColor.colorBlack
        self.labelDetail.textColor = UIColor.AppColor.colorAppTextLightGray
        self.viewLine1.backgroundColor = UIColor.AppColor.colorAppGray
        self.viewLine2.backgroundColor = UIColor.AppColor.colorAppGray
      
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if((self.superview) != nil){
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.width, height: self.superview!.height)
            self.contentView?.frame = self.frame
		}
	}
	
	//MARK:- SETUP
    func  updateData() {
        
        self.labelCategoryName.text = "Electrician"
        self.labelServiceProvider.text = "Red seal electrician for custome"
        self.labelDetail.text = "I Have 4 years Electrician ecperiense and an currently a red seal "
        
        
    }
}
