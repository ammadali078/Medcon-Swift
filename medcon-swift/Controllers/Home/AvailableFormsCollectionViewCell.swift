//
//  DetailCollectionViewCell.swift
//  medcon-swift
//
//  Created by Ccomputing on 08/09/2022.
//

import Foundation
import UIKit

class AvailableFormCell: NSObject,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var dataList: [Forms] = []
    var filteredList : [Forms] = []
    
    var openType = "0"
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvailableFormCell", for: indexPath) as! AvailableFormViewCell
        
        cell.mainHeadingLbl.text = filteredList[indexPath.row].brand
        cell.subHeadinglbl.text = filteredList[indexPath.row].company
        cell.typeLbl.text = filteredList[indexPath.row].type
        cell.activeInglbl.text = filteredList[indexPath.row].active_ingredient
        cell.quantityLabelView.text = filteredList[indexPath.row].quantity
        cell.packingLabelView.text = filteredList[indexPath.row].packing
        cell.tradeLabelView.text = filteredList[indexPath.row].actual_price
        cell.MrPLabelView.text = filteredList[indexPath.row].retail_price
        
        return cell
        
    }
    
    func setItems (items: [Forms]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
//        self.openType = openType
        
    }
    
}

class AvailableFormViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainHeadingLbl: UILabel!
    @IBOutlet weak var subHeadinglbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var activeInglbl: UILabel!
    @IBOutlet weak var quantityLabelView: UILabel!
    @IBOutlet weak var packingLabelView: UILabel!
    @IBOutlet weak var tradeLabelView: UILabel!
    @IBOutlet weak var MrPLabelView: UILabel!
    
}
