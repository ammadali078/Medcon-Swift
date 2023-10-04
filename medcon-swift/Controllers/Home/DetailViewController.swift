//
//  DetailViewController.swift
//  medcon-swift
//
//  Created by Ccomputing on 08/09/2022.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class DetailViewController: UIViewController,UISearchBarDelegate{
    
    @IBOutlet weak var DetailTableViewCell: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var detailListDataSource: detailTableCell!
    var OpenType = "0";
    var selectedData: JsonData? = nil
    var index = 0 ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        detailListDataSource = detailTableCell()
        DetailTableViewCell.dataSource = detailListDataSource
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.genPage, withJson: "\(1)")
        
        detailListDataSource.onStartClick = {JsonData in
            self.onStartClick(JsonData: JsonData)
        }
        
        let btn = CommonUtils.getJsonFromUserDefaults(forKey: Constants.btn)
        
        if btn == "1"{
            self.Genricbrand()
        }else if btn == "2"{
            self.facturerIndex()
        }else if btn == "3"{
            self.brandsAvailable()
        }else {
            
            self.DrugInteractionApi()
        }
    }
    
    func onStartClick(JsonData: JsonData)  {
        
        self.selectedData = JsonData
        let selectedID = selectedData?.id
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.selId, withJson:  String(selectedID ?? 0))
        
        let btn = CommonUtils.getJsonFromUserDefaults(forKey: Constants.btn)
        
        if btn == "2" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrandDetailscene") as! BrandDetailViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AvailableFormsViewScene") as! AvailableFormsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let predicateString = searchBar.text
        detailListDataSource.filteredData(searchText: predicateString!)
        self.DetailTableViewCell.reloadData()
        
    }
    
    func Genricbrand(){
        
        var  parms = Dictionary<String, Any>()
        
        parms["token"] = "71745275081679";
        parms["page"] = 1;
        
        AF.request(Constants.BrandApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
//                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                    return
                }
                
                let genBranModel = Mapper<GenBranModel>().map(JSONString: response.value!) //JSON to model
                
                if genBranModel != nil {
                    
                    if genBranModel?.status == "success" {
                        
                        let List = genBranModel?.data?.data ?? []
                        
                        self.detailListDataSource.setItems(items: List, openType: self.OpenType)
                        self.DetailTableViewCell.reloadData()
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
            })
    }
    
    func facturerIndex(){
        
        var  parms = Dictionary<String, String>()
        
        parms["token"] = "71745275081679";
        
        AF.request(Constants.FecturerApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
//                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                    return
                }
                
                let genBranModel = Mapper<GenBranModel>().map(JSONString: response.value!) //JSON to model
                
                if genBranModel != nil {
                    
                    if genBranModel?.status == "success" {
                        
                        let List = genBranModel?.data?.data ?? []
                        
                        self.detailListDataSource.setItems(items: List, openType: self.OpenType)
                        self.DetailTableViewCell.reloadData()
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
                
            })
        
    }
    
    func brandsAvailable(){
        
        var  parms = Dictionary<String, String>()
        
        parms["token"] = "71745275081679";
        
        AF.request(Constants.AvailableApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
//                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                    return
                }
                
                let genBranModel = Mapper<GenBranModel>().map(JSONString: response.value!) //JSON to model
                
                if genBranModel != nil {
                    
                    if genBranModel?.status == "success" {
                        
                        let List = genBranModel?.data?.data ?? []
                        
                        let filter = List.filter {($0.name != "-")}
                        
                        self.detailListDataSource.setItems(items: filter, openType: self.OpenType)
                        self.DetailTableViewCell.reloadData()
                        
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
            })
    }
    
    func DrugInteractionApi(){
        
        var  parms = Dictionary<String, String>()
        
        parms["token"] = "71745275081679";
        
        AF.request(Constants.DrugInterApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
//                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                    return
                }
                
                let genBranModel = Mapper<GenBranModel>().map(JSONString: response.value!) //JSON to model
                
                if genBranModel != nil {
                    
                    if genBranModel?.status == "success" {
                        
                        let List = genBranModel?.data?.data ?? []
                        
                        let filter = List.filter {($0.name != "-")}
                        
                        self.detailListDataSource.setItems(items: filter, openType: self.OpenType)
                        self.DetailTableViewCell.reloadData()
                        
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
            })
    }
    
    @IBAction func btnMore(_ sender: Any) {
        
        let select = CommonUtils.getJsonFromUserDefaults(forKey: Constants.btn)
        
        if select == "1"{
            
            let indexPage = Int(CommonUtils.getJsonFromUserDefaults(forKey: Constants.genPage)) ?? 0
            
            let index = indexPage + 1
            
            var  parms = Dictionary<String, Any>()
            
            parms["token"] = "71745275081679";
            parms["page"] = index;
            
            AF.request(Constants.BrandApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    // On Response
                    
                    //On Dialog Close
                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                        return
                    }
                    
                    let genBranModel = Mapper<GenBranModel>().map(JSONString: response.value!) //JSON to model
                    
                    if genBranModel != nil {
                        
                        if genBranModel?.status == "success" {
                            
                            let List = genBranModel?.data?.data ?? []
                            
                            self.detailListDataSource.setItems(items: List, openType: self.OpenType)
                            self.DetailTableViewCell.reloadData()
                            
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.genPage, withJson: genBranModel?.request?.page ?? "0")
                            
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                    }
                    
                })
            
        }else if select == "2"{
            
            let indexPage = Int(CommonUtils.getJsonFromUserDefaults(forKey: Constants.genPage)) ?? 0
            
            let index = indexPage + 1
            
            var  parms = Dictionary<String, Any>()
            
            parms["token"] = "71745275081679";
            parms["page"] = index;
            
            AF.request(Constants.FecturerApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    // On Response
                    
                    //On Dialog Close
                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                        return
                    }
                    
                    let genBranModel = Mapper<GenBranModel>().map(JSONString: response.value!) //JSON to model
                    
                    if genBranModel != nil {
                        
                        if genBranModel?.status == "success" {
                            
                            let List = genBranModel?.data?.data ?? []
                            
                            self.detailListDataSource.setItems(items: List, openType: self.OpenType)
                            self.DetailTableViewCell.reloadData()
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.genPage, withJson: genBranModel?.request?.page ?? "0")
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                    }
                    
                })
            
            
        }else if select == "3"{
            
            let indexPage = Int(CommonUtils.getJsonFromUserDefaults(forKey: Constants.genPage)) ?? 0
            
            let index = indexPage + 1
            
            var  parms = Dictionary<String, Any>()
            
            parms["token"] = "71745275081679";
            parms["page"] = index;
            
            AF.request(Constants.AvailableApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    // On Response
                    
                    //On Dialog Close
                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                        return
                    }
                    
                    let genBranModel = Mapper<GenBranModel>().map(JSONString: response.value!) //JSON to model
                    
                    if genBranModel != nil {
                        
                        if genBranModel?.status == "success" {
                            
                            let List = genBranModel?.data?.data ?? []
                            
                            let filter = List.filter {($0.name != "-")}
                            
                            self.detailListDataSource.setItems(items: filter, openType: self.OpenType)
                            self.DetailTableViewCell.reloadData()
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.genPage, withJson: genBranModel?.request?.page ?? "0")
                            
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                    }
                    
                })
            
        }else {
            
            let indexPage = Int(CommonUtils.getJsonFromUserDefaults(forKey: Constants.genPage)) ?? 0
            
            let index = indexPage + 1
            
            var  parms = Dictionary<String, Any>()
            
            parms["token"] = "71745275081679";
            parms["page"] = index;
            
            AF.request(Constants.DrugInterApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    // On Response
                    
                    //On Dialog Close
                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                        return
                    }
                    
                    let genBranModel = Mapper<GenBranModel>().map(JSONString: response.value!) //JSON to model
                    
                    if genBranModel != nil {
                        
                        if genBranModel?.status == "success" {
                            
                            let List = genBranModel?.data?.data ?? []
                            
                            let filter = List.filter {($0.name != "-")}
                            
                            self.detailListDataSource.setItems(items: filter, openType: self.OpenType)
                            self.DetailTableViewCell.reloadData()
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.genPage, withJson: genBranModel?.request?.page ?? "0")
                            
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                    }
                })
        }
    }
}
