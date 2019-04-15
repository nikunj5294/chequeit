//
//  AICollectionViewCategory.swift
//   
//
//  Created by Govind ravaliya on 27/06/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit

class CHCollectionViewItemList: AICollectionView {
	
	// MARK:- PROPERTIES
    var arrDataSource : NSMutableArray =  NSMutableArray()
    var arrayData : [CHItemList]! = [CHItemList]()
    var blockCollectionViewDidSelectAtIndexPath:((IndexPath,CHItemList)->Void)?
	
    var isCookItem : Bool = false
    
    
    
	private let marginVertical:CGFloat =  getProportionalWidth(width: 0)
	private let marginHorizontal:CGFloat = getProportionalWidth(width: 0)
	private let marginLeftRight:CGFloat = getProportionalWidth(width: 0)
	private let topMargin:CGFloat = getProportionalHeight(height: 10)
	
	// MARK:- INIT
	override func awakeFromNib() {
        
		super.awakeFromNib()
		self.doSetupCollectionView()
		
        arrayData = AIJsonManager.getItemListData()
        
        self.delegate = self
        self.dataSource = self

        
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if self.arrDataSource.count > 0 {
			self.contentInset = UIEdgeInsetsMake(topMargin, marginLeftRight, topMargin, marginLeftRight)
		}else{
			self.contentInset = UIEdgeInsetsMake(topMargin, 0, 0, 0)
		}
	}
	
	// MARK:- SETUP COLLECTIONVIEW
	func doSetupCollectionView() {
		
		self.register(UINib(nibName: "CellitemList", bundle: nil), forCellWithReuseIdentifier: "CellitemList")
		let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		self.collectionViewLayout = flowLayout
		self.backgroundColor = UIColor.AppColor.colorWhite
		self.contentInset = UIEdgeInsetsMake(topMargin, marginLeftRight, topMargin, marginLeftRight)
		self.allowsMultipleSelection = false
		
	}
    func setBgType(type : BGType)  {
        
        
        let filteredArray = arrayData.filter() {
            if let type1 : String = ($0 as CHItemList).type {
                return type1.range(of: "\(type)") != nil
            } else {
                return false
            }
        }
        
        arrayData.removeAll()
        arrayData = filteredArray
        
     
        
        reloadData()
        
    }
	
	
	
	// MARK:- UICOLLECTIONVIEW DATASOURCE
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.arrayData.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellitemList", for: indexPath)  as! CellitemList
        cell.setupWithIndexPath(indexPath: indexPath, andDataSource: arrayData[indexPath.row])
        return cell
		
	}
    
	
	//MARK:
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return marginVertical
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return marginHorizontal
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
        let cellWidth   = ((self.width - marginVertical - marginHorizontal - marginLeftRight - marginLeftRight)) - 1
        let cellHeight  = (self.height - (topMargin * 2)) / 3
        return CGSize(width: cellWidth, height: cellHeight)
    }
	
	//MARK:- DID SELECT
    
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
        if isCookItem == true {
        
            if self.blockCollectionViewDidSelectAtIndexPath != nil {
                self.blockCollectionViewDidSelectAtIndexPath!(indexPath,arrayData[indexPath.row])
            }
        }
        
        
//        let category = self.arrayData[indexPath.item]
//        category.IsSelected = !category.IsSelected
//        updateCellForSelectedState()
	}
	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
	
//        let category = self.arrayData[indexPath.item]
//        category.IsSelected = !category.IsSelected
//        updateCellForSelectedState()
	}
	
	//MARK:-
	func updateCellForSelectedState(){
		

        self.reloadData()
	}
}
