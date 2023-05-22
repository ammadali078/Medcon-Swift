//
//  PAMViewAllController.swift
//  medcon-swift
//
//  Created by Macbook on 26/04/2023.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class PAMViewAllController: UIViewController{
    
    @IBOutlet weak var viewAllCollectionView: UICollectionView!
    
    
    var allArticleListDataSource: AllArticlePAMCell!
    var OpenType = "0";
    
    override func viewDidLoad() {
        
        allArticleListDataSource = AllArticlePAMCell()
        viewAllCollectionView.dataSource = allArticleListDataSource
        self.allPAMArtice()
        
    }
    
    func allPAMArtice() {
        
        var  parms = Dictionary<String, Any>()
        
        parms["page"] = 1;
        
        AF.request(Constants.PAMArtApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    return
                }
                
                let pAMModel = Mapper<PAMModel>().map(JSONString: response.value!) //JSON to model
                
                if pAMModel != nil {
                    
                    if pAMModel?.success == true {
                        
                        
                        let List = pAMModel?.data?[0].patientAwareness ?? []
                        
                        self.allArticleListDataSource.setItems(items: List, openType: self.OpenType)
                        self.viewAllCollectionView.reloadData()
                        
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
                
            })
        
    }
    
    
}
