//
//  PAMViewController.swift
//  medcon-swift
//
//  Created by Macbook on 14/04/2023.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class PAMViewController: UIViewController{
    
    @IBOutlet weak var pAMCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var popularCollectionViewOutlet: UICollectionView!
    
    var OpenType = "0";
    var PAMListDataSource: PAMCollectionCell!
    var popularDataSource: PopularCollectionCell!
    var indicator: UIActivityIndicatorView!
    var activitiyViewController: ActivityViewController!
    var selectedData: MostPopularResult? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PAMListDataSource = PAMCollectionCell()
        pAMCollectionViewOutlet.dataSource = PAMListDataSource
        popularDataSource = PopularCollectionCell()
        popularCollectionViewOutlet.dataSource = popularDataSource
        
        popularDataSource.onStartClick = {MostPopularResult in
            self.onStartClick(MostPopularResult: MostPopularResult)
        }
        
        self.GetArticle()
        self.getPopularArt()
        
    }
    
    @IBAction func articleViewAllBtn(_ sender: Any) {
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ArtID, withJson: "3")
        let mainViewController: ViewAllArticlesViewController = UIStoryboard(storyboard: .home).instantiateVC()
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    func onStartClick(MostPopularResult: MostPopularResult)  {
        
        self.selectedData = MostPopularResult
//        let selectedID = selectedData?.id
//
//        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selId, withJson:  String(selectedID ?? 0))
//
//        let btn = CommonUtils.getJsonFromUserDefaults(forKey: Constants.btn)
//
//        if btn == "2" {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrandDetailscene") as! BrandDetailViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//
//        }else {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AvailableFormsViewScene") as! AvailableFormsViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
    
    func GetArticle(){
        
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
                        
                        self.PAMListDataSource.setItems(items: List, openType: self.OpenType)
                        self.pAMCollectionViewOutlet.reloadData()
                        
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
                
            })
        
    }
    
    func getPopularArt(){
        
        var  parms = Dictionary<String, Any>()
        
        parms["count"] = 5;
        
        AF.request(Constants.PopularApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    return
                }
                
                let PopularModel = Mapper<MostPopularModel>().map(JSONString: response.value!) //JSON to model
                
                if PopularModel != nil {
                    
                    if PopularModel?.success == true {
                        
                        let List = PopularModel?.data
                        
                        self.popularDataSource.setItems(items: List, openType: self.OpenType)
                        self.popularCollectionViewOutlet.reloadData()
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
                
            })
        
    }
    
    @IBAction func viewAllArticleBtn(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PAMViewAllScene") as! PAMViewAllController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
