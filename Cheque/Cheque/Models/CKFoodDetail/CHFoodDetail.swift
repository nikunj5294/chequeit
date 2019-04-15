//
//  AICategory.swift
//   
//
//  Created by Govind ravaliya on 27/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit

class CHFoodDetail: NSObject {
    
    let kTitle = "title"
    let kDetail = "detail"
    let kIsExpanded = "isExpanded"
    
    var Title : String = ""
    var Detail:String = ""
    var IsExpanded:Bool = false
    
    
    //MARK:- INIT
    override init() {
        super.init()
    }
    
    init(dict:NSDictionary) {
        self.Title = dict.object_forKeyWithValidationForClass_String(aKey: kTitle)
        self.Detail = dict.object_forKeyWithValidationForClass_String(aKey: kDetail)
        self.IsExpanded = dict.object_forKeyWithValidationForClass_Bool(aKey:kIsExpanded)
    }
    
}


class CHAmazonItem: NSObject {
    
    let kTitle = "title"
    let kImage = "image"
    let kPrize = "prize"
    let kNumberOfItem = "numberofitem"
    
    var title : String = ""
    var image : String = ""
    var prize : String = ""
    var numberOfItem : Int = 1
    
    
    
    //MARK:- INIT
    override init() {
        super.init()
    }
    
    init(dict:NSDictionary) {
        self.title = dict.object_forKeyWithValidationForClass_String(aKey: kTitle)
        self.image = dict.object_forKeyWithValidationForClass_String(aKey: kImage)
        self.prize = dict.object_forKeyWithValidationForClass_String(aKey:kPrize)
        self.numberOfItem =  dict.object_forKeyWithValidationForClass_Int(aKey: kNumberOfItem)
        
    }
    
}

class CHMapItem: NSObject {
    
    let kTitle = "title"
    let kImage = "image"
    let kAddress = "address"
    
    var title : String = ""
    var image : String = ""
    var address : String = ""
    
    
    
    //MARK:- INIT
    override init() {
        super.init()
    }
    
    init(dict:NSDictionary) {
        self.title = dict.object_forKeyWithValidationForClass_String(aKey: kTitle)
        self.image = dict.object_forKeyWithValidationForClass_String(aKey: kImage)
        self.address = dict.object_forKeyWithValidationForClass_String(aKey:kAddress)
        
    }
    
}


