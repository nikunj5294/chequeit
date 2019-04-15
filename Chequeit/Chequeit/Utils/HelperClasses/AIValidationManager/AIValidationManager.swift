//
//  AIValidationManager.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit

//MARK:- VALIDATION CONSTANTS

let MINIMUM_CHAR_NAME = 3
let MAXIMUM_CHAR_NAME = 64

let MINIMUM_CHAR_EMAIL = 3
let MAXIMUM_CHAR_EMAIL = 60

let MINIMUM_CHAR_CITY = 3
let MAXIMUM_CHAR_CITY = 30

let MAXIMUM_CHAR_POSTAL_CODE = 6

let MINIMUM_CHAR_PASSWORD = 6
let MAXIMUM_CHAR_PASSWORD = 16

let MINIMUM_CHAR_PHONE_NUMBER = 8
let MAXIMUM_CHAR_PHONE_NUMBER = 15

let MINIMUM_CHAR_ADDRESS = 2
let MAXIMUM_CHAR_ADDRESS = 256

let MAXIMUM_CHAR_CARD_NUMBER = 16

let MAXIMUM_CHAR_CVV = 3

let MINIMUM_CHAR_MESSAGE = 10
let MAXIMUM_CHAR_MESSAGE = 1000





enum AIValidationRule: Int {
	case
	EmptyCheck,
	MinMaxLength,
	FixedLength,
	EmailCheck,
	UpperCase,
	LowerCase,
	SpecialCharacter,
	DigitCheck,
	WhiteSpaces,
	None
}


let ValidationManager = AIValidationManager.sharedManager


class AIValidationManager: NSObject {
	
	// MARK: - SHARED MANAGER -
	static let sharedManager = AIValidationManager()
	
	
	//MARK:- VALIDATION CHECK
	func validateTextField(txtField:AITextField, forRule rule:AIValidationRule, withMinimumChar minChar:Int, andMaximumChar maxChar:Int) -> (isValid:Bool, errMessage:String, txtFieldWhichFailedValidation:AITextField)? {
		
		switch rule {
			
		case .EmptyCheck:
			return (txtField.text?.characters.count == 0) ? (false,"Please enter your \(txtField.placeholder!.lowercased()).",txtField) : nil
			
			
		case .MinMaxLength:
//			return (txtField.text!.characters.count < minChar || txtField.text!.characters.count > maxChar) ? (false,"\(txtField.placeholder!) should be of \(minChar) to \(maxChar) characters",txtField) : nil

			return (txtField.text!.characters.count < minChar) ? (false,"\(txtField.placeholder!) should contain at least \(minChar) characters.",txtField) : nil

			
		case .FixedLength:
			return (txtField.text!.characters.count != minChar) ? (false,"\(txtField.placeholder!) should be of \(minChar) characters.",txtField) : nil
			
			
		case .EmailCheck:
			return (!(txtField.text?.isValidEmail())!) ? (false,"Please enter valid \(txtField.placeholder!.lowercased()).",txtField) : nil
			
			
		case .UpperCase:
			return ((txtField.text! as NSString).rangeOfCharacter(from: NSCharacterSet.uppercaseLetters).location == NSNotFound) ? (false,"\(txtField.placeholder!) should contain at least one uppercase letter.",txtField) : nil
			
			
		case .LowerCase:
			return ((txtField.text! as NSString).rangeOfCharacter(from: NSCharacterSet.lowercaseLetters).location == NSNotFound) ? (false,"\(txtField.placeholder!) should contain at least one lowercase letter.",txtField) : nil
			
			
		case .SpecialCharacter:
			let symbolCharacterSet = NSMutableCharacterSet.symbol()
			symbolCharacterSet.formUnion(with: NSCharacterSet.punctuationCharacters)
			return ((txtField.text! as NSString).rangeOfCharacter(from: symbolCharacterSet as CharacterSet).location == NSNotFound) ? (false,"\(txtField.placeholder!) should contain at least one special letter.",txtField) : nil
			
			
		case .DigitCheck:
			return ((txtField.text! as NSString).rangeOfCharacter(from: NSCharacterSet(charactersIn: "0123456789") as CharacterSet).location == NSNotFound) ? (false,"\(txtField.placeholder!) should contain at least one digit letter.",txtField) : nil
			
		case .WhiteSpaces:
			return (txtField.text!.containsAdjacentSpaces() || txtField.text!.isLastCharcterAWhiteSpace()) ? (false,"\(txtField.placeholder!) seems to be invalid.",txtField) : nil
			
		case .None:
			return nil
		}
	}
	
	
	func validateTextField(txtField:AITextField, forRules rules:[AIValidationRule]) -> (isValid:Bool, errMessage:String, txtFieldWhichFailedValidation:AITextField)? {
		return validateTextField(txtField: txtField, forRules: rules, withMinimumChar: 0, andMaximumChar: 0)
	}
	
	
	
	func validateTextField(txtField:AITextField, forRules rules:[AIValidationRule], withMinimumChar minChar:Int, andMaximumChar maxChar:Int) -> (isValid:Bool, errMessage:String, txtFieldWhichFailedValidation:AITextField)? {
		
		var strMessage:String = ""
		for eachRule in rules {
			
			if let result = validateTextField(txtField: txtField, forRule: eachRule, withMinimumChar: minChar, andMaximumChar: maxChar) {
				if(eachRule == AIValidationRule.EmptyCheck){
					return result
				}else{
					strMessage += "\(strMessage.characters.count == 0 ? "" : "\n\n") \(result.errMessage)"
				}
			}
		}
		return strMessage.characters.count > 0 ? (false,strMessage,txtField) : nil
	}
}
