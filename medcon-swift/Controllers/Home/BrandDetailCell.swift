//
//  BrandDetailViewCell.swift
//  medcon-swift
//
//  Created by macbook on 16/09/2022.
//

import Foundation
import UIKit


class BrandDetailCell : NSObject, UITableViewDelegate, UITableViewDataSource {

        var openType = "0"
        var dataList: [BrandsDetail] = []
        var filteredList : [BrandsDetail] = []
        
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 900
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandDetailCell", for: indexPath) as! BrandDetailViewCell
        cell.medNameLbl.text = filteredList[indexPath.row].brand
        cell.medCompanyLbl.text = filteredList[indexPath.row].company
        cell.typeViewLbl.text = "Tablets"
        cell.activeIngViewLbl.text = filteredList[indexPath.row].active_ingredient
        cell.quantityViewLbl.text = filteredList[indexPath.row].quantity
        cell.packingViewLbl.text = filteredList[indexPath.row].packing
        cell.tradePriceViewLbl.text = filteredList[indexPath.row].actual_price
        cell.mrpViewLbl.text = filteredList[indexPath.row].retail_price
        
        return cell
    
    }
    
    
    func setItems (items: [BrandsDetail]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
//        self.openType = openType
        
    }
    
    
}
class BrandDetailViewCell : UITableViewCell {
    
    
    @IBOutlet weak var medNameLbl: UILabel!
    @IBOutlet weak var medCompanyLbl: UILabel!
    @IBOutlet weak var typeViewLbl: UILabel!
    @IBOutlet weak var activeIngViewLbl: UILabel!
    @IBOutlet weak var quantityViewLbl: UILabel!
    @IBOutlet weak var packingViewLbl: UILabel!
    @IBOutlet weak var tradePriceViewLbl: UILabel!
    @IBOutlet weak var mrpViewLbl: UILabel!
    
    
}
