//
//  Extension_String.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

enum scripting : Int
{
    case aSub = -1
    case aSuper = 1
}


extension String {
	
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    subscript(integerIndex: Int) -> Character {
		let index = self.index(self.startIndex, offsetBy: integerIndex)
		return self[index]
	}
	
    var length: Int {
        return self.characters.count
    }
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
	var getTimeIn24Format: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mm a"
		
		let date = dateFormatter.date(from: self)
		
		
		return (date?.hourTwoDigit24Hours)!
	}
	var getTimeIn12Format : String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH:mm:ss"
		let date = dateFormatter.date(from: self)
		return (date?.hourTwoDigit)!
	}
	var getDateFromString: Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mm a"
		dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
		let date = dateFormatter.date(from: self)
		return date!
	}

	
	
	func isLastCharcterAWhiteSpace() -> Bool{
		
		if(self.characters.count == 0){
			return false
		}
		
		var result:Bool = false
		if(self.characters.count == 1){
			result = self[0] == " "
		}else{
			result = self[self.characters.count-1] == " "
		}
		
		return result
	}
	
	func containsAdjacentSpaces() -> Bool{
		
		if(self.characters.count == 0){
			return false
		}
		
		var result = false
		if(self.characters.count == 1){
			result = false
		}else{
			var wasLastCharacterAWhiteSpace = false
			for i in 0..<self.characters.count{
				let currentChar = self[i] as Character
				print(currentChar)
				if(currentChar == " "){
					if(wasLastCharacterAWhiteSpace){
						return true
					}
					wasLastCharacterAWhiteSpace = true
				}else{
					wasLastCharacterAWhiteSpace = false
				}
			}
		}
		return result
	}
	
	func whiteSpaceTrimmed() -> String{
		return self.components(separatedBy: NSCharacterSet.whitespaces).filter({ !$0.isEmpty }).joined(separator: " ")
	}
	
	func heightWithWidthAndFont(width: CGFloat, font: UIFont) -> CGFloat {
		
		let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
		return boundingBox.height
	}
	
	func isValidEmail() -> Bool	{
		return ( (isValidEmail_OLD(stringToCheckForEmail: self as String))  && (isValidEmail_NEW(stringToCheckForEmail: self as String)) )
	}
	
	func isValidEmail_OLD(stringToCheckForEmail:String) -> Bool {
		let emailRegex = "[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Z0-9a-z]+([.-]{1}[A-Z0-9a-z]+)*(\\.[A-Za-z]{2,4}){0,1}"
		return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: stringToCheckForEmail)
	}
	
	func isValidEmail_NEW(stringToCheckForEmail:String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: stringToCheckForEmail)
	}
	
	var containsEmoji: Bool {
		get {
			for scalar in unicodeScalars {
				switch scalar.value {
				case 0x1F600...0x1F64F, // Emoticons
				0x1F300...0x1F5FF, // Misc Symbols and Pictographs
				0x1F680...0x1F6FF, // Transport and Map
				0x2600...0x26FF,   // Misc symbols
				0x2700...0x27BF,   // Dingbats
				0xFE00...0xFE0F:   // Variation Selectors
					return true
				default:
					continue
				}
			}
			return false
		}
	}
    
    func nsRange(fromRange range: Range<Index>) -> NSRange {
        let from = range.lowerBound
        let to = range.upperBound
        
        let location = characters.distance(from: startIndex, to: from)
        let length = characters.distance(from: from, to: to)
        
        return NSRange(location: location, length: length)
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont, Spacing spacing:CGFloat) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return (ceil(boundingBox.width) + spacing)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont, Spacing spacing:CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return (ceil(boundingBox.height) + spacing)
    }
    
    public static func localize(_ key: String, comment: String) -> String {
        return NSLocalizedString(key, comment: comment)
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension NSAttributedString {
    
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
    
  
}
