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
    var selectedData: MostPopularResult? = nil
    var selectedCell: PatientAwareness? = nil
    var segImage: [UIImage] = [
        UIImage(named: "1stSeg.png")!,
        UIImage(named: "2ndSeg.png")!,
        UIImage(named: "3rdSeg.png")!
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PAMListDataSource = PAMCollectionCell()
        pAMCollectionViewOutlet.dataSource = PAMListDataSource
        popularDataSource = PopularCollectionCell()
        popularCollectionViewOutlet.dataSource = popularDataSource
        
                popularDataSource.onStartClick = {MostPopularResult in
                    self.onStartClick(MostPopularResult: MostPopularResult)
                }
        
        PAMListDataSource.onStartClick = {PatientAwareness in
            self.onStartClick(PatientAwareness: PatientAwareness)
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
            let selectedID = selectedData?.id
    
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.PopularID, withJson:  String(selectedID ?? 0))
    
            let btn = CommonUtils.getJsonFromUserDefaults(forKey: Constants.btn)
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.checkID, withJson: "1")
    
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PAMAticleDetailViewScene") as! PAMAticleDetailViewController
            self.navigationController?.pushViewController(vc, animated: true)
    
        }
    
    func onStartClick(PatientAwareness: PatientAwareness)  {
        
        self.selectedCell = PatientAwareness
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.checkID, withJson: "0")
        
        let img = self.selectedCell?.imageUrl
        let title = self.selectedCell?.title
        let html = self.selectedCell?.html
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.getImg, withJson: img ?? "")
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.getTitle, withJson: title ?? "")
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.getHtml, withJson: html ?? "")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PAMAticleDetailViewScene") as! PAMAticleDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func GetArticle(){
        
        var  parms = Dictionary<String, Any>()
        
        parms["page"] = 1;
        
        AF.request(Constants.PAMArtApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                
                    //On Dialog Close
                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
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
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
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
