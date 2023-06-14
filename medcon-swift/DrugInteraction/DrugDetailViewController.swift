//
//  DrugDetailViewController.swift
//  medcon-swift
//
//  Created by Macbook on 30/05/2023.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class DrugDetailViewController: UIViewController{
    
    @IBOutlet weak var medDesView: UIView!
    @IBOutlet weak var medTextLabel: UILabel!
    @IBOutlet weak var drugDetailCollectionView: UICollectionView!
    
    var DrugDetailDataSource: DrugDetailCollectonCell!
    var OpenType = "0";
    
    override func viewDidLoad() {
        
        DrugDetailDataSource = DrugDetailCollectonCell()
        drugDetailCollectionView.dataSource = DrugDetailDataSource
        medDesView.isHidden = true
        medDesView.layer.cornerRadius = 8
        medDesView.layer.masksToBounds = true
        
        self.getMedDetail()
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.number, withJson: "")
        
    }
    
    func getMedDetail() {
        
        var  parms = Dictionary<String, Any>()
        
        let value = CommonUtils.getJsonFromUserDefaults(forKey: Constants.medID2)
        
        parms["rxcuis"] = value;
        parms["sources"] = "DrugBank";
        
        AF.request(Constants.getMedDetailApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
//                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                    return
                }
                
                let drugDetailModel = Mapper<DrugDetailModel>().map(JSONString: response.value!) //JSON to model
                
                if drugDetailModel != nil {
                    
                    if drugDetailModel?.fullInteractionTypeGroup == nil {
                        self.medDesView.isHidden = false
                        self.drugDetailCollectionView.isHidden = true
                        
                        self.medTextLabel.text = drugDetailModel?.nlmDisclaimer
                        
                    }else{
                        
                        self.medDesView.isHidden = true
                        self.drugDetailCollectionView.isHidden = false
                        let List = drugDetailModel?.fullInteractionTypeGroup?[0].fullInteractionType
                        
                        self.DrugDetailDataSource.setItems(items: List, openType: self.OpenType)
                        self.drugDetailCollectionView.reloadData()
                        
                        
                    }
                    
                    
                    
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
                
            })
        
    }
    
    
    @IBAction func clearAllBtn(_ sender: Any) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.medID2, withJson: "")
        _ = navigationController?.popViewController(animated: true)
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.number, withJson: "1")

        
    }
    
    
}
