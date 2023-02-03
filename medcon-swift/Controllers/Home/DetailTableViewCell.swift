//
//  DetailTableViewCell.swift
//  medcon-swift
//
//  Created by Ccomputing on 08/09/2022.
//

import Foundation
import UIKit


class detailTableCell : NSObject ,UITableViewDelegate,UITableViewDataSource {
    var dataList: [JsonData] = []
    var filteredList : [JsonData] = []
    var openType = "0"
    var onStartClick: ((JsonData) -> Void)? = nil
    
    var medicines = ["(Amfebutamone hydrochloride) 30's","(Amfebutamone hydrochloride) 30's","(Amfebutamone hydrochloride) 30's","(Amfebutamone hydrochloride) 30's","(Amfebutamone hydrochloride) 30's"]
    
    var medFor = ["(GlaxoSmithKline)","(GlaxoSmithKline)","(GlaxoSmithKline)","(GlaxoSmithKline)","(GlaxoSmithKline)"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailTableCell", for: indexPath) as! DetailTableViewCell
        
        
//        let ammad = filteredList.filter {($0.name != "-")}
        
//        let ammad = filteredList.filter(where {($0.name == "-")}<#(JsonData) throws -> Bool#>)
        
        let index = indexPath.row
        let Json = filteredList[index]
        cell.JsonData = Json
        cell.medNameLbl.text = filteredList[indexPath.row].name
        cell.onStartClick = onStartClick
       
        let btn = CommonUtils.getJsonFromUserDefaults(forKey: Constants.btn)
        
        if btn == "1" {
            cell.medFormulaLbl.text = "(" + filteredList[indexPath.item].company! + ")"
        }else{
            cell.medFormulaLbl.isHidden = true
            
        }
         return cell
        
    }
    
    func setItems (items: [JsonData]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
//        self.openType = openType
        
    }
    
    func filteredData(searchText: String ) {
        if searchText .isEmpty {
            setItems(items: dataList, openType: openType)
            return
        }
        filteredList = dataList.filter({$0.name?.lowercased().range(of: searchText.lowercased()) != nil})
                filteredList.sorted(by: {
                    guard let first: String = ($0 as AnyObject).title else { return false }
                    guard let second: String = ($1 as AnyObject).title else { return true }
        
                    return first > second
                })
    }
    
}

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var medNameLbl: UILabel!
    @IBOutlet weak var medFormulaLbl: UILabel!
    var JsonData: JsonData? = nil
    var onStartClick: ((JsonData) -> Void)? = nil
    
    @IBAction func onSelectedBtn(_ sender: Any) {
        onStartClick!(JsonData!)
    }
    
    
}
