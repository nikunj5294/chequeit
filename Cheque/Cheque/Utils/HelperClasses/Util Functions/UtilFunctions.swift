//
//  UtilFunctions.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import Foundation
import UIKit




//MARK:- AttributedText

func attributedTexts(_ object : AnyObject , text1: String , text1FontSize : CGFloat, text2: String , text2FontSize : CGFloat) -> NSMutableAttributedString {
	
	let mainFont = object.font
	let font1 = mainFont!.withSize(CGFloat(text1FontSize).proportionalFontSize())
    let attr1 = [NSAttributedStringKey.font: font1]
	
	let font2 = font1.withSize(CGFloat(text2FontSize).proportionalFontSize())
    let attr2 = [NSAttributedStringKey.font: font2]
	
	let str = NSMutableAttributedString(string: text1, attributes: attr1);
	str.append(NSAttributedString(string: text2, attributes: attr2))
	
	return str
}


// MARK:- STRING FROM DICT
// MARK:
func getStringFromDictionary(dict:Any) -> String{
	var strJson = ""
	do {
		let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
		strJson = String(data: data, encoding: String.Encoding.utf8)!
	} catch let error as NSError {
		print("json error: \(error.localizedDescription)")
	}
	
	return strJson
}


// MARK:- INTERNET CHECK
// MARK:
func isInternetAvailable() -> Bool{
    return AIReachabilityManager.shared.isInternetAvailableForAllNetworks()
}


// MARK:-    Get Current TimeStamp
// MARK:
var timeStamp: String {
    return "\(NSDate().timeIntervalSince1970 * 1000)"
}


// MARK:-    Calculate available free space & total space
// MARK:
var availableFreeSpace:String {
    get{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths.last!) {
            if let freeSize = dictionary[FileAttributeKey.systemFreeSize] as? NSNumber {
                return "\(freeSize.int64Value/(1024*1024))"
            }
        }else{
            print("Error Obtaining System Memory Info:")
        }
        return ""
    }
}
// Get Total size
func getTotalSize() -> Int64?{
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    if let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths.last!) {
        if let freeSize = dictionary[FileAttributeKey.systemSize] as? NSNumber {
            return freeSize.int64Value
        }
    }else{
        print("Error Obtaining System Memory Info:")
    }
    return nil
}

// MARK:-    DEBUG PRINT MODE
// MARK:
func printT(items: AnyObject) {
    
    if _isDebugAssertConfiguration() {
        print(items)
    } else {
        
    }
}







