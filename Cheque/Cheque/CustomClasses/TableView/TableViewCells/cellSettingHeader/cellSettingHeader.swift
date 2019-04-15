//
//  CellSideMenu.swift
//  Asra
//
//  Created by c on 08/08/16.
//  Copyright © 2016 . All rights reserved.
//

import UIKit

class cellSettingHeader: BaseTableViewCell {

    
    @IBOutlet var lbl_TotalItem: CHLabelBold!
    
    var blockCheckOutClick:((CHButton)->Void)?
 
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lbl_TotalItem.textColor = UIColor.black
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    

    
    
}
