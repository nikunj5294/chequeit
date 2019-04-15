//
//  Extension_UILabel.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import Foundation
import UIKit

extension UILabel {
	
	func setLineHeight(lineHeight: CGFloat) {
		self.setLineHeight(lineHeight: lineHeight, withAlignment: .left)
	}
	
	func setLineHeight(lineHeight: CGFloat, withAlignment alignment:NSTextAlignment) {
		let text = self.text
		if let text = text {
			let attributeString = NSMutableAttributedString(string: text)
			
			let style = NSMutableParagraphStyle()
			style.lineSpacing = lineHeight
			style.alignment = alignment
			
            attributeString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSMakeRange(0, text.characters.count))
			self.attributedText = attributeString
		}
	}
}

extension UILabel {
	
	
	func addImageWith(name: String, behindText: Bool) {
		
		let attachment = NSTextAttachment()
		attachment.image = UIImage(named: name)
		let attachmentString = NSAttributedString(attachment: attachment)
		
		
		guard let txt = self.text else {
			return
		}
		
		
		if behindText {
			
			let strLabelText = NSMutableAttributedString(string: txt)
			strLabelText.append(attachmentString)
			
			self.attributedText = strLabelText
			
		} else {
			 
			let strLabelText = NSAttributedString(string: txt)
			let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
			mutableAttachmentString.append(strLabelText)
			
			self.attributedText = mutableAttachmentString
			
		}
		
	}
	
	func removeImage() {
		
		let text = self.text
		self.attributedText = nil
		self.text = text
	}
   
    func AttributFont(font:UIFont ) -> [NSAttributedStringKey : Any] {
        
        return   [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) :font]
        
    }
    
    func setThreeTypeText(s1:String,
                          s2:String,
                          s3:String,
                          s4:String,
                          s5:String,
                          s6:String,
                          s7:String,
                          s8:String,
                          s9:String,
                          s10:String ) {
        
        let bigFont = AttributFont(font: UIFont.appFont_Regular(fontSize: self.font.pointSize + 6))
        let boldFont = AttributFont(font: UIFont.appFont_Bold(fontSize: self.font.pointSize))
        let regularFont = AttributFont(font: UIFont.appFont_Regular(fontSize: self.font.pointSize + 3))
        
        
        
        let myString1 = NSMutableAttributedString(string: s1,  attributes: bigFont)
        let myString2 = NSMutableAttributedString(string: s2, attributes: regularFont)
        let myString3 = NSMutableAttributedString(string: s3, attributes: boldFont)
        let myString4 = NSMutableAttributedString(string: s4, attributes: regularFont)
        let myString5 = NSMutableAttributedString(string: s5, attributes: boldFont)
        let myString6 = NSMutableAttributedString(string: s6, attributes: regularFont)
        let myString7 = NSMutableAttributedString(string: s7, attributes: boldFont)
        let myString8 = NSMutableAttributedString(string: s8, attributes: regularFont)
        let myString9 = NSMutableAttributedString(string: s9, attributes: boldFont)
        let myString10 = NSMutableAttributedString(string: s10, attributes: regularFont)
        
        
        
        let myRange1 = NSRange(location: 0, length: s1.characters.count)
        myString1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange1)
        
        
        let myRange2 = NSRange(location: 0, length: s2.characters.count)
        myString2.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange2)
        
        let myRange3 = NSRange(location: 0, length: s3.characters.count)
        myString3.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange3)
       
        let myRange4 = NSRange(location: 0, length: s4.characters.count)
        myString4.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange4)
        
        let myRange5 = NSRange(location: 0, length: s5.characters.count)
        myString5.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange5)
        
        
        let myRange6 = NSRange(location: 0, length: s6.characters.count)
        myString6.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange6)
        
        
        let myRange7 = NSRange(location: 0, length: s7.characters.count)
        myString7.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange7)
        
        let myRange8 = NSRange(location: 0, length: s8.characters.count)
        myString8.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange8)
        
        let myRange9 = NSRange(location: 0, length: s9.characters.count)
        myString9.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange9)
        
        let myRange10 = NSRange(location: 0, length: s10.characters.count)
        myString10.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: myRange10)
        
        
        
        let FinalString : NSMutableAttributedString = NSMutableAttributedString()
        
        FinalString.append(myString1)
        FinalString.append(myString2)
        FinalString.append(myString3)
        FinalString.append(myString4)
        FinalString.append(myString5)
        FinalString.append(myString6)
        FinalString.append(myString7)
        FinalString.append(myString8)
        FinalString.append(myString9)
        FinalString.append(myString10)
        
        
        
        
        self.attributedText = FinalString
        
    }
}
