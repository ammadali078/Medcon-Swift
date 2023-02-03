//
//  BrandDetailViewController.swift
//  medcon-swift
//
//  Created by macbook on 16/09/2022.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class BrandDetailViewController: UIViewController{
    
    @IBOutlet weak var BrandDetailTableView: UITableView!
    @IBOutlet weak var nameLabelView: UILabel!
    @IBOutlet weak var addressNameLabelView: UILabel!
    
    @IBOutlet weak var telephoneLabelView: UILabel!
    @IBOutlet weak var faxLabelView: UILabel!
    
    var BrandListDataSource: BrandDetailCell!
    var OpenType = "0";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        BrandListDataSource = BrandDetailCell()
        BrandDetailTableView.dataSource = BrandListDataSource
        
        AvailableApi()
        
    }
    
    func AvailableApi(){

        let selId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selId)

            var  parms = Dictionary<String, String>()

            parms["token"] = "85677466274605";
            parms["id"] = selId;

            AF.request(Constants.BrandDetailApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    // On Response

                        //On Dialog Close
                        if (response.error != nil) {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                            return
                        }

                        let brandDetailModel = Mapper<BrandDetailModel>().map(JSONString: response.value!) //JSON to model

                        if brandDetailModel != nil {

                            if brandDetailModel?.status == "success" {

                                self.nameLabelView.text = brandDetailModel?.data?.name
                                self.addressNameLabelView.text = brandDetailModel?.data?.address
                                self.telephoneLabelView.text = brandDetailModel?.data?.tel
                                self.faxLabelView.text = brandDetailModel?.data?.fax
                                
                                let List = brandDetailModel?.brands

                                self.BrandListDataSource.setItems(items: List, openType: self.OpenType)
                                self.BrandDetailTableView.reloadData()

//
                            } else {
                                CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                            }
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                        }

                })

            }
}
