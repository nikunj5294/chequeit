//
//  AILabel.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit


class CHLabel: AILabel {

	//MARK:- INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		commonInit()
	}
	
	private func commonInit(){
        self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
		//self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
	}
}

class CHLabelBold: AILabelBold {
	
	//MARK:- INIT
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		commonInit()
	}
	
	private func commonInit(){
		self.font = UIFont.appFont_Bold(fontSize: self.font!.pointSize.proportionalFontSize())
	}
}


class CHLabelItalic: AILabel {
    
    //MARK:- INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit(){
        self.font = UIFont.appFont_Italic(fontSize: self.font!.pointSize.proportionalFontSize())
    }
}




