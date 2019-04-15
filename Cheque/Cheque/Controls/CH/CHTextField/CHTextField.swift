//
//  iFitTextfield.swift
//  iFit
//
//  Created by K@V!N on 06/06/17.
//  Copyright © 2017 abc. All rights reserved.
//



import UIKit

enum ChTextFieldType {
    
    case standard
    case Search
    case Location
}


enum AITextFieldValidationType : Int {
    
    case text
    case text_NOSPACE
    
    case text_Number
    case text_Number_NOSPACE
    
    case text_Characters
    case text_Characters_NOSPACE
    
    case name
    case name_NOSPACE
    
    case float
    
    case phone
    case number
    case number_Nozero
    
    case email
    case password
    
}


enum ChTextFieldTypeLine {
    
    case standard
}

class ChTextField: UITextField {
    
    //MARK:- PROPERTIES
    
    var shouldPreventAllActions:Bool = false
    var canCut:Bool = true
    var canCopy:Bool = true
    var canPaste:Bool = true
    var canSelect:Bool = true
    var canSelectAll:Bool = true
    
    var needToLayoutSubviews:Bool = true
    
    var maxLength : NSInteger?
    var minLength : NSInteger?
    
    // textfiled validation type
    var txtType : AITextFieldValidationType?
    var textFieldValidationType :AITextFieldValidationType {
        get {
            return self.textFieldValidationType
        }
        set {
            txtType = newValue
        }
    }
    
    //MARK:- INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    //MARK:- ChNGHT VALIDATION
    //MARK:
    func setUpTextFieldForLengthValidation(_ minLength : NSInteger, maxLength : NSInteger) {
        self.maxLength = maxLength
        self.minLength = minLength
    }
    
    func commonInit(){
        
        //DELEGATE
        self.delegate = self
        
        //VALIDATIONS
        if (self.minLength == nil) {
            self.minLength = 0
        }
        
        if (self.maxLength == nil  || self.maxLength == 0) {
            self.maxLength = 256
        }
        
        //self.borderStyle = .none
        
        self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
        self.tintColor =  UIColor.AppColor.colorBlack
        
        if(self.placeholder != nil ){
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes:[NSAttributedStringKey.foregroundColor: UIColor.AppColor.colorLightGray])
        }
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 15))
        self.leftViewMode = .always
        
        self.autocorrectionType = .no
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.needToLayoutSubviews {
            
            self.applyBorder(color: UIColor.AppColor.colorLightGray, width: 1)
            self.backgroundColor = UIColor.AppColor.colorAppLightGray
            self.needToLayoutSubviews = false
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if(self.shouldPreventAllActions){
            return false
        }
        
        switch action {
        case #selector(UIResponderStandardEditActions.cut(_:)):
            return self.canCut ? super.canPerformAction(action, withSender: sender) : self.canCut
        case #selector(UIResponderStandardEditActions.copy(_:)):
            return self.canCopy ? super.canPerformAction(action, withSender: sender) : self.canCopy
        case #selector(UIResponderStandardEditActions.paste(_:)):
            return self.canPaste ? super.canPerformAction(action, withSender: sender) : self.canPaste
        case #selector(UIResponderStandardEditActions.select(_:)):
            return self.canSelect ? super.canPerformAction(action, withSender: sender) : self.canSelect
        case #selector(UIResponderStandardEditActions.selectAll(_:)):
            return self.canSelectAll ? super.canPerformAction(action, withSender: sender) : self.canSelectAll
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }
}


extension ChTextField:  UITextFieldDelegate{
    
    
    func textFieldEditChange(_ textField : UITextField) -> Void {
        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if  txtType == .text ||
            txtType == .text_NOSPACE ||
            txtType == .text_Number ||
            txtType == .text_Number_NOSPACE ||
            txtType == .text_Characters ||
            txtType == .text_Characters_NOSPACE ||
            txtType == .name ||
            txtType == .name_NOSPACE  {
            
            textField.keyboardType = UIKeyboardType.default
        }
        else if txtType == .float{
            
            textField.keyboardType = UIKeyboardType.decimalPad
        }

        else if txtType == .phone ||
            txtType == .number ||
            txtType == .number_Nozero{
            
            textField.keyboardType = UIKeyboardType.phonePad
        }
        else if txtType == .email {
            textField.keyboardType = UIKeyboardType.emailAddress
        }
        else if txtType == .password {
            textField.keyboardType = UIKeyboardType.numbersAndPunctuation
            textField.isSecureTextEntry = true
        }
        
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let trimmedString = textField.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        textField.text = trimmedString
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.location == 0 && (string == " ") {
            return false
        }
        
        if self.maxLength != 0 {
            if range.location >= self.maxLength! {
                return false
            }
        }
        
        self.checkEmoji(string)
        
        if  txtType == .text ||
            txtType == .text_NOSPACE ||
            txtType == .text_Number ||
            txtType == .text_Number_NOSPACE ||
            txtType == .text_Characters ||
            txtType == .text_Characters_NOSPACE ||
            txtType == .name ||
            txtType == .name_NOSPACE  {
            
            return self.checkTextBlock(textField, range: range, string: string)
        }
        else if txtType == .phone ||
            txtType == .number ||
            txtType == .number_Nozero ||
            txtType == .float
        {
            
            return self.checkNumberBlock(textField, range: range, string: string)
        }
        else if txtType == .email ||
            txtType == .password {
            
            return self.checkEmailAndPasswordBlock(textField, range: range, string: string)
        }
        
        return true
    }
    
    // MARK: ALL VALIDATION
    
    func checkTextBlock(_ textField: UITextField,range: NSRange,string: String) -> Bool  {
        
        var charactersToBlock : CharacterSet = CharacterSet()
        
        
        if txtType == .text{
            charactersToBlock = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*(){}[]_-+*/~`.?<> ")
        }
        else if txtType == .text_NOSPACE {
            charactersToBlock = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*(){}[]_-+*/~`.?<>")
        }
        else if txtType == .text_Number{
            charactersToBlock = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")
        }
        else if txtType == .text_Number_NOSPACE {
            charactersToBlock = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        }
        else if txtType == .text_Characters{
            charactersToBlock = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*(){}[]_-+*/~`.?<> ")
        }
        else if txtType == .text_Characters_NOSPACE {
            charactersToBlock = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*(){}[]_-+*/~`.?<>")
        }
        else if txtType == .name {
            charactersToBlock = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
        }
        else if txtType == .name_NOSPACE {
            charactersToBlock = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        }
        
        
        if range.location == 0 {
            if string.hasPrefix(" ") {
                return false
            }
        }
        let length: Int = textField.text!.characters.count
        if length > 0 {
            let originalString: String = textField.text!
            let index: Int = length
            var theCharacter : String = String()
            theCharacter = String(originalString[originalString.characters.index(originalString.startIndex, offsetBy: index-1)])
            
            if theCharacter.hasPrefix(" ") && string.hasPrefix(" ") {
                return false
            }
        }
        if (string == "") {
            return true
        }
        
        if (string.rangeOfCharacter(from: charactersToBlock) != nil) {
            return true
        }
        else {
            return false
        }
        
        
        
    }
    
    func checkNumberBlock(_ textField: UITextField,range: NSRange,string: String) -> Bool  {
        
        var charactersToBlock : CharacterSet = CharacterSet()
        
        if txtType == .phone{
            charactersToBlock = CharacterSet(charactersIn:"0123456789")
            if (range.location == 0 &&  string == " ") || (range.location == 0 &&  string == "0") {
                return false
            }
        }
        else if txtType == .float {
            charactersToBlock = CharacterSet(charactersIn: "0123456789.")
        }
        else if txtType == .number {
            charactersToBlock = CharacterSet(charactersIn: "0123456789")
        }
        else if txtType == .number_Nozero{
            charactersToBlock = CharacterSet(charactersIn: "123456789")
        }
        
        if range.location == 0 {
            if string.hasPrefix(" ") {
                return false
            }
        }
        if string == ""  {
            return true
        }
        
        if (string.rangeOfCharacter(from: charactersToBlock) != nil) {
            return true
        }
        else {
            return false
        }
        
    }
    
    func checkEmailAndPasswordBlock(_ textField: UITextField,range: NSRange,string: String) -> Bool  {
        
        var charactersToBlock : CharacterSet = CharacterSet()
        
        if txtType == .email || txtType == .password{
            charactersToBlock = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*(){}[]_-+*/~`.?<>")
        }
        
        
        if range.location == 0 {
            if string.hasPrefix(" ") {
                return false
            }
        }
        if (string == "") {
            return true
        }
        if (string.rangeOfCharacter(from: charactersToBlock) != nil) {
            return true
        }
        else {
            return false
        }
        
    }
    
    func checkEmoji(_ string : String) -> Bool {
        
        let emojiRanges = [
            0x1F601...0x1F64F,
            0x2702...0x27B0,
            0x1F680...0x1F6C0,
            0x1F170...0x1F251
        ]
        
        for range in emojiRanges {
            for i in range {
                let c = String(describing: UnicodeScalar(i))
                if (string == c) {
                    return false
                }
            }
        }
        
        return true
        
    }
    
}


class CHTextFieldLine: UITextField {
    
    //MARK:- PROPERTIES
    
    var shouldPreventAllActions:Bool = false
    var canCut:Bool = true
    var canCopy:Bool = true
    var canPaste:Bool = true
    var canSelect:Bool = true
    var canSelectAll:Bool = true
    var needToLayoutSubviews:Bool = true
    var maxLength : NSInteger?
    var minLength : NSInteger?
    var txtType : AITextFieldValidationType?
    var textFieldValidationType :AITextFieldValidationType {
        get {
            return self.textFieldValidationType
        }
        set {
            txtType = newValue
        }
    }
    
    var blocKNumberOfCharacter:((Int)->Void)?
    
    
    //MARK:- INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit(){
        
        //DELEGATE
       // self.delegate = self
        
        //VALIDATIONS
        if (self.minLength == nil) {
            self.minLength = 0
        }
        if (self.maxLength == nil  || self.maxLength == 0) {
            self.maxLength = 256
        }
        
        self.borderStyle = .none
        
        self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
        self.tintColor =  UIColor.AppColor.colorWhite
        
        if(self.placeholder != nil ){
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes:[NSAttributedStringKey.foregroundColor: UIColor.AppColor.colorAppLightWhite])
        }
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 15))
        self.leftViewMode = .always
        
        self.autocorrectionType = .no
        
      //  modifyClearButtonWithImage(image: #imageLiteral(resourceName: "cross"))
    }
    
    //MARK:- LENGHT VALIDATION
    //MARK:
    func setUpTextFieldForLengthValidation(_ minLength : NSInteger, maxLength : NSInteger) {
        self.maxLength = maxLength
        self.minLength = minLength
    }
    
    func modifyClearButtonWithImage(image : UIImage) {
        
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(self.clear(sender:)), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .always
    }
    
    @objc func clear(sender : AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.needToLayoutSubviews {
            
            self.addBorderWithColor(color: UIColor.AppColor.colorLightGray, edge: AIEdge.Bottom, thicknessOfBorder: 1)
            self.backgroundColor = UIColor.AppColor.colorClear
            self.needToLayoutSubviews = false
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if(self.shouldPreventAllActions){
            return false
        }
        
        switch action {
        case #selector(UIResponderStandardEditActions.cut(_:)):
            return false // self.canCut ? super.canPerformAction(action, withSender: sender) : self.canCut
        case #selector(UIResponderStandardEditActions.copy(_:)):
            return false // self.canCopy ? super.canPerformAction(action, withSender: sender) : self.canCopy
        case #selector(UIResponderStandardEditActions.paste(_:)):
            return false // self.canPaste ? super.canPerformAction(action, withSender: sender) : self.canPaste
        case #selector(UIResponderStandardEditActions.select(_:)):
            return false // self.canSelect ? super.canPerformAction(action, withSender: sender) : self.canSelect
        case #selector(UIResponderStandardEditActions.selectAll(_:)):
            return false // self.canSelectAll ? super.canPerformAction(action, withSender: sender) : self.canSelectAll
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }
}

