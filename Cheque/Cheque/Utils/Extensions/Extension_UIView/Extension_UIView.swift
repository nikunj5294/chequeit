//
//  Extension_UIView.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import Foundation
import UIKit


//MARK:- AIEdge
enum AIEdge:Int {
	case
	Top,
	Left,
	Bottom,
	Right,
	Top_Left,
	Top_Right,
	Bottom_Left,
	Bottom_Right,
	All,
	None
}


extension UIView {
	
	//MARK:- HEIGHT / WIDTH
	
	var width:CGFloat {
		return self.frame.size.width
	}
	var height:CGFloat {
		return self.frame.size.height
	}
	var xPos:CGFloat {
		return self.frame.origin.x
	}
	var yPos:CGFloat {
		return self.frame.origin.y
	}
	
	//MARK:- DASHED BORDER
	func drawDashedBorderAroundView() {
		let cornerRadius: CGFloat = self.frame.size.width / 2
		let borderWidth: CGFloat = 0.5
		let dashPattern1: Int = 4
		let dashPattern2: Int = 2
		let lineColor = UIColor.AppColor.colorWhite
		
		//drawing
		let frame: CGRect = self.bounds
		let shapeLayer = CAShapeLayer()
		//creating a path
		let path: CGMutablePath = CGMutablePath()
		
		//drawing a border around a view
		path.move(to: CGPoint(x: CGFloat(0), y: CGFloat(frame.size.height - cornerRadius)), transform: .identity)
		path.addLine(to: CGPoint(x: CGFloat(0), y: CGFloat(cornerRadius)), transform: .identity)
		path.addArc(center: CGPoint(x: CGFloat(cornerRadius), y: CGFloat(cornerRadius)), radius: CGFloat(cornerRadius), startAngle: CGFloat(Double.pi), endAngle: CGFloat(-Double.pi / 2), clockwise: false, transform: .identity)
		path.addLine(to: CGPoint(x: CGFloat(frame.size.width - cornerRadius), y: CGFloat(0)), transform: .identity)
        path.addArc(center: CGPoint(x: CGFloat(frame.size.width - cornerRadius), y: CGFloat(cornerRadius)), radius: CGFloat(cornerRadius), startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat(0), clockwise: false, transform: .identity)
		path.addLine(to: CGPoint(x: CGFloat(frame.size.width), y: CGFloat(frame.size.height - cornerRadius)), transform: .identity)
		path.addArc(center: CGPoint(x: CGFloat(frame.size.width - cornerRadius), y: CGFloat(frame.size.height - cornerRadius)), radius: CGFloat(cornerRadius), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi / 2), clockwise: false, transform: .identity)
		path.addLine(to: CGPoint(x: CGFloat(cornerRadius), y: CGFloat(frame.size.height)), transform: .identity)
		path.addArc(center: CGPoint(x: CGFloat(cornerRadius), y: CGFloat(frame.size.height - cornerRadius)), radius: CGFloat(cornerRadius), startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: false, transform: .identity)
		
		//path is set as the _shapeLayer object's path
		
		shapeLayer.path = path
		shapeLayer.backgroundColor = UIColor.clear.cgColor
		shapeLayer.frame = frame
		shapeLayer.masksToBounds = false
		shapeLayer.setValue(NSNumber(value: false), forKey: "isCircle")
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.strokeColor = lineColor.cgColor
		shapeLayer.lineWidth = borderWidth
		shapeLayer.lineDashPattern = [NSNumber(integerLiteral: dashPattern1),NSNumber(integerLiteral: dashPattern2)]
		shapeLayer.lineCap = kCALineCapRound
		
		self.layer.addSublayer(shapeLayer)
	}
	
	
	//MARK:- ROTATE
	func rotate(angle: CGFloat) {
		let radians = angle / 180.0 * CGFloat(Double.pi)
		self.transform = self.transform.rotated(by: radians);
	}
	
	
	
	//MARK:- BORDER
	func applyBorderDefault() {
		self.applyBorder(color: UIColor.red, width: 1.0)
	}
	func applyBorderDefault1() {
		self.applyBorder(color: UIColor.green, width: 1.0)
	}
	func applyBorderDefault2() {
		self.applyBorder(color: UIColor.blue, width: 1.0)
	}
	func applyBorder(color:UIColor, width:CGFloat) {
		DispatchQueue.main.async {
			self.layer.borderColor = color.cgColor
			self.layer.borderWidth = width
		}
	}
	
	
	//MARK:- CIRCLE
	func applyCircle() {
		self.applyCornerRadius(radius: min(self.frame.size.height, self.frame.size.width) * 0.5)
	}
	
	//MARK:- CORNER RADIUS
	func applyCornerRadius(radius:CGFloat) {
		DispatchQueue.main.async {
			self.layer.cornerRadius = radius
			self.layer.masksToBounds = true
		}
	}
    func applyDashedBorder(radius:CGFloat) {
        DispatchQueue.main.async {
            var yourViewBorder = CAShapeLayer()
            yourViewBorder.strokeColor = UIColor.AppColor.colorLightGray.cgColor
            yourViewBorder.lineDashPattern = [2, 2]
            yourViewBorder.frame = self.bounds
            yourViewBorder.fillColor = nil
            yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
            self.layer.addSublayer(yourViewBorder)
        }
    }
	
  
	
	//MARK:- SHADOW

	func applyShadowWithColor(color:UIColor, opacity:Float, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat)	{
		
		var sizeOffset:CGSize = CGSize.zero
		switch edge {
		case .Top:
			sizeOffset = CGSize(width: 0, height: -shadowSpace) //CGSizeMake(0, -shadowSpace)
		case .Left:
			sizeOffset = CGSize(width: -shadowSpace, height: 0) //CGSizeMake(-shadowSpace, 0)
		case .Bottom:
			sizeOffset = CGSize(width: 0, height: shadowSpace) //CGSizeMake(0, shadowSpace)
		case .Right:
			sizeOffset = CGSize(width: shadowSpace, height: 0) //CGSizeMake(shadowSpace, 0)
			
			
		case .Top_Left:
			sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace) //CGSizeMake(-shadowSpace, -shadowSpace )
		case .Top_Right:
			sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace) //CGSizeMake(shadowSpace, -shadowSpace)
		case .Bottom_Left:
			sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace) //CGSizeMake(-shadowSpace, shadowSpace)
		case .Bottom_Right:
			sizeOffset = CGSize(width: shadowSpace, height: shadowSpace) //CGSizeMake(shadowSpace, shadowSpace)
			
			
		case .All:
			sizeOffset = CGSize(width: 0, height: 0) //CGSizeMake(0, 0)
		case .None:
			sizeOffset = CGSize.zero
		}
		
		self.layer.shadowColor = color.cgColor
		self.layer.shadowOpacity = opacity
		self.layer.shadowOffset = sizeOffset
		self.layer.shadowRadius = radius
//		self.clipsToBounds = false
		self.layer.masksToBounds = false
	}
	
	
	func addBorderWithColor(color:UIColor, edge:AIEdge, thicknessOfBorder:CGFloat)	{

		
		DispatchQueue.main.async {
			
			var rect:CGRect = CGRect.zero
			
			switch edge {
			case .Top:
				rect = CGRect(x: 0, y: 0, width: self.width, height: thicknessOfBorder) //CGRectMake(0, 0, self.width, thicknessOfBorder);
			case .Left:
				rect = CGRect(x: 0, y: 0, width: thicknessOfBorder, height:self.width ) //CGRectMake(0, 0, thicknessOfBorder, self.height);
			case .Bottom:
				rect = CGRect(x: 0, y: self.height - thicknessOfBorder, width: self.width, height: thicknessOfBorder) //CGRectMake(0, self.height - thicknessOfBorder, self.width, thicknessOfBorder);
			case .Right:
				rect = CGRect(x: self.width-thicknessOfBorder, y: 0, width: thicknessOfBorder, height: self.height) //CGRectMake(self.width-thicknessOfBorder, 0,thicknessOfBorder, self.height);
			default:
				break
			}
			
			let layerBorder = CALayer()
			layerBorder.frame = rect
			layerBorder.backgroundColor = color.cgColor
			self.layer.addSublayer(layerBorder)
		}
	}
	
	//MARK:- ANIMATE VIBRATE
	func animateVibrate() {
		
		let duration = 0.05
		
		UIView.animate(withDuration: duration ,
		                           animations: {
									self.transform = self.transform.translatedBy(x: 5, y: 0)
		},
		                           completion: { finish in
									
									UIView.animate(withDuration: duration ,
									                           animations: {
																self.transform = self.transform.translatedBy(x: -10, y: 0)
									},
									                           completion: { finish in
																
																
																UIView.animate(withDuration: duration ,
																                           animations: {
																							self.transform = self.transform.translatedBy(x: 10, y: 0)
																},
																                           completion: { finish in
																							
																							
																							UIView.animate(withDuration: duration ,
																							                           animations: {
																														self.transform = self.transform.translatedBy(x: -10, y: 0)
																							},
																							                           completion: { finish in
																														
																														UIView.animate(withDuration: duration){
																															self.transform = CGAffineTransform.identity
																														}
																							})
																})
									})
		})
	}
}
