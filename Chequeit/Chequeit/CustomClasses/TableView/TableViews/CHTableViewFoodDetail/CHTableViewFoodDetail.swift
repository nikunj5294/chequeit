//
//  ServiceSelectionTableView.swift
//   
//
//  Created by Govind ravaliya on 19/10/17.
//  Copyright © 2017 Govind Ravaliya. All rights reserved.
//

import UIKit


class CHTableViewFoodDetail : BaseTableView {
    
    
    var cell_DetailHead: cellDetailHead?
    var cell_Detail: cellDetail?
    var cell_DetailExpande: cellDetailExpande?
    var arrDataSource : NSMutableArray =  NSMutableArray()
    var arrayData : [String]! = []()
    
    //Block
    var blockBtnTitlePressHandler_Table:((CHButtonBold,Int)->Void)?
    var blockBtnViewPressHandler_Table:((CHButton,Int)->Void)?
    var blockBtnDidSelect:((Int)->Void)?

    
    var dicSelectedItem : CHItemList!
    
    
    //MARK:- TableView Life Cycle
    //MARK:-
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.doSetUptableView()
    }
    
    func doSetUptableView() {
        
        
        self.doSetUpData()
        
        // REUSE CELL
        self.register(UINib(nibName:"cellDetailHead", bundle: nil), forCellReuseIdentifier: "cellDetailHead")
        self.register(UINib(nibName:"cellDetail", bundle: nil), forCellReuseIdentifier: "cellDetail")
        self.register(UINib(nibName:"cellDetailExpande", bundle: nil), forCellReuseIdentifier: "cellDetailExpande")
       
        // ADD HEADER VIEW
        cell_DetailHead = self.dequeueReusableCell(withIdentifier: "cellDetailHead") as? cellDetailHead
        self.tableHeaderView = cell_DetailHead
        
        self.backgroundColor = UIColor.white
        self.isScrollEnabled = true
        self.separatorStyle = .none
        self.dataSource = self
        self.delegate = self
    }
    
    func doSetUpData() {
        

        
        arrayData = AIJsonManager.getFoodDetailData()
        arrayData[0].IsExpanded = true
        self.reloadData()
        
    }
    
    func setVenueDetail() {
        
        // ADD HEADER VIEW
        cell_DetailHead = self.dequeueReusableCell(withIdentifier: "cellDetailHead") as? cellDetailHead
        cell_DetailHead?.updateCell(data: dicSelectedItem)
        
        self.tableHeaderView = cell_DetailHead
    }
    
}

//MARK:- UITableViewDataSource
extension CHTableViewFoodDetail: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section {
        case 0:
            return  (arrayData[section].IsExpanded == true) ? dicSelectedItem.Ingredients.count : 0
        case 1:
            return  (arrayData[section].IsExpanded == true) ? dicSelectedItem.Directions.count : 0
        default:
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
      
        cell_DetailExpande = self.dequeueReusableCell(withIdentifier: "cellDetailExpande") as? cellDetailExpande
        
        switch indexPath.section {
        case 0:
            cell_DetailExpande?.updateCell(data: dicSelectedItem.Ingredients[indexPath.row])
        case 1:
            cell_DetailExpande?.updateCell(data: dicSelectedItem.Directions[indexPath.row])
        default: break
       
        }
        
        //cell_DetailExpande?.updateCell(data: arrayData[0])
        return cell_DetailExpande!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        self.cell_Detail = self.dequeueReusableCell(withIdentifier: "cellDetail") as? cellDetail
        switch section {
        case 0:
            self.cell_Detail?.updateCell(data: "Ingredients", index: section)
        case 1:
            self.cell_Detail?.updateCell(data: "Directions to cook", index: section)
        default: break
            
        }
        
        
        
        cell_Detail?.blockBtnClick = { sender in
            self.expandeCell(button: sender as UIButton, section: section)
        }
        cell_Detail?.blockGetClick = { sender in
            if self.blockBtnDidSelect != nil{
                self.blockBtnDidSelect!(section)
            }
        }
        
        return cell_Detail!
    }
    
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.proportionalHeight(70.0)
    }
   
    
    func expandeCell(button:UIButton, section: Int) {
     
        arrayData[section].IsExpanded =  !arrayData[section].IsExpanded
        self.reloadData()
    }
    
   
}


//MARK: - UITableViewDelegate
extension CHTableViewFoodDetail: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if self.blockBtnDidSelect != nil{
            self.blockBtnDidSelect!(indexPath.row)
        }
    }
    
}
