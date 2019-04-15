//
//  CellCVCategory.swift
//   
//
//  Created by Govind ravaliya on 27/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit

class CellFoodFrom: AICollectionViewCell {
	
	//MARK:- OUTLETS
	@IBOutlet weak var viewContainer: UIView!
	@IBOutlet weak var imageViewPhoto: UIImageView!
	@IBOutlet weak var lblTitle: CHLabel!
    
    @IBOutlet weak var viewRounded: UIView!
    //MARK:- INIT
	override func awakeFromNib() {
		super.awakeFromNib()
		//imageViewPhoto.applyBorder(color: UIColor.AppColor.colorGreen, width: 1)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.viewContainer.applyCornerRadius(radius: 2)
		self.imageViewPhoto.applyCornerRadius(radius: 2)
        self.viewContainer.backgroundColor = UIColor.AppColor.colorClear
        self.viewRounded.applyCircle()
        self.viewRounded.applyBorder(color: UIColor.AppColor.colorLightBlue, width: 3.0)
        
     }
	
	//MARK:- CELL SETUP
    
    func setupWithIndexPath(indexPath:IndexPath, andDataSource: Any) {
     
        lblTitle.text = (andDataSource as? [String : AnyObject])?["title"] as? String
        imageViewPhoto.image = ImageNamed(name: (andDataSource as? [String : AnyObject])?["image"] as! String)
        
        self.layoutIfNeeded()
    }
    
	func setupWithIndexPath(indexPath:IndexPath, andDataSource recommendItem:LEFoodFrom ) {
		
        lblTitle.text = recommendItem.Title
        imageViewPhoto.image = ImageNamed(name:recommendItem.ImageName)
        
        self.layoutIfNeeded()
	}
	
}
