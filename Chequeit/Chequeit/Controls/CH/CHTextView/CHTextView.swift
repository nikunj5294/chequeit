//
//  AITextView.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit
//import PureLayout


class CKTextView: UITextView , UITextViewDelegate {
	
	//MARK:- PROPERTIES
	var lblPlaceHolder : AILabel?
	
	var strPlaceHolder:String = "Type.." {
		didSet{
			self.lblPlaceHolder?.text = strPlaceHolder
		}
	}
	
	override open var text: String! {
		didSet {
			 lblPlaceHolder?.isHidden = !text.isEmpty
		}
	}
	
	var blockTextViewShouldChangeTextInRangeWithReplacementText:((_ textView: UITextView, _ range: NSRange, _ text: String) -> Bool)?
    var blockTextViewDidEndEditing:(()->(Void))?
	
	var needToLayoutSubviews:Bool = true
	
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		
		var shouldReturn:Bool = true
		
		if text == "\n" {
			return true
		}
		if(self.blockTextViewShouldChangeTextInRangeWithReplacementText != nil){
			shouldReturn = self.blockTextViewShouldChangeTextInRangeWithReplacementText!(textView, range, text)
		}
		
		let fullText = (textView.text! as NSString).replacingCharacters(in: range, with: text);
		lblPlaceHolder?.isHidden = !fullText.isEmpty
		
		return shouldReturn
	}

	
	//MARK:- INIT
	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		self.commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		self.commonInit()
	}
	
	private func commonInit() {
		
		self.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize.proportionalFontSize())
        self.tintColor = UIColor.AppColor.colorBlack
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
		self.delegate = self
		
		self.clipsToBounds = true
		
		// ADDING PLACEHOLDER LABEL
		if(self.lblPlaceHolder == nil){
			self.lblPlaceHolder = AILabel(forAutoLayout: ())
			self.addSubview(self.lblPlaceHolder!)
			self.lblPlaceHolder?.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset:self.textContainerInset.left + 5)
			self.lblPlaceHolder?.autoPinEdge(toSuperviewEdge: ALEdge.top, withInset: self.textContainerInset.top)
			//self.lblPlaceHolder?.text = self.strPlaceHolder
			self.lblPlaceHolder?.font = UIFont.appFont_Regular(fontSize: self.font!.pointSize)
			self.lblPlaceHolder?.textColor = UIColor.AppColor.colorAppGray
		}
		
		
	}
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
    }

	
	//MARK:- TEXTVIEW DELEGATE
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if(self.blockTextViewDidEndEditing != nil){
			self.blockTextViewDidEndEditing!()
		}
	}

}



@IBDesignable
open class CHPlaceholderTextView: UITextView {
    
    private struct Constants {
        static let defaultiOSPlaceholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
    }
    open let placeholderLabel: UILabel = UILabel()
    
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    @IBInspectable open var placeholderColor: UIColor = CHPlaceholderTextView.Constants.defaultiOSPlaceholderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override open var font: UIFont! {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }
    
    open var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: NSNotification.Name.UITextViewTextDidChange,
                                               object: nil)
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }
    
    private func updateConstraintsForPlaceholderLabel() {
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(textContainerInset.top))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints.append(NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1.0,
            constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        ))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UITextViewTextDidChange,
                                                  object: nil)
    }
    
}

