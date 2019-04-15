//
//  CellSideMenu.swift
//  Asra
//
//  Created by c on 08/08/16.
//  Copyright © 2016 . All rights reserved.
//

import UIKit

class cellSideMenu: BaseTableViewCell {

    
    @IBOutlet var lbl_Title: CHLabel!
    @IBOutlet var img_Icon: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lbl_Title.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    

    func  UpdateCell(menuDetailCell:[String:String]) {
        
        lbl_Title.text = menuDetailCell["Title"]
        img_Icon.image = UIImage(named: menuDetailCell["Icon"]!)
        
    }
    
    
    
}
