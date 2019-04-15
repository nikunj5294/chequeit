//
//  AICollectionView.swift
//   
//
//  Created by Govind ravaliya on 22/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//


import UIKit

class AICollectionView: UICollectionView , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	
	//MARK:- PROPERTIES
	//var viewPlaceHolder:AIViewPlaceHolder!
	
	
	//MARK:- INIT
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		commonInit()
	}
	
	private func commonInit(){
		self.delegate = self
		self.dataSource = self
		self.showsVerticalScrollIndicator = false
		self.showsHorizontalScrollIndicator = false
		
		// PLACE HOLDER VIEW
		//self.viewPlaceHolder = AIViewPlaceHolder()
//        self.viewPlaceHolder.setupPlaceHolderViewWith(message: "NO DATA FOUND", andImageName: "")
//        self.addSubview(self.viewPlaceHolder)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	
	//MARK:- SHOW / HIDE LOADER
	func showLoader(){
	//	self.viewPlaceHolder.showLoader()
	}
	func hideLoader(){
	//	self.viewPlaceHolder.hideLoader()
	}

	
	
	//MARK:- DATASOURCE
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: Devices.screenWidth, height: 50))
	}
	
	//MARK:- DELEGATE
}
