//
//  DrugInterActionViewController.swift
//  medcon-swift
//
//  Created by Macbook on 23/05/2023.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class DrugInterActionViewController: UIViewController,UISearchBarDelegate{
    
    
    @IBOutlet weak var DrugCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var noResultLabel: UILabel!
    
    @IBOutlet weak var noResultView: UIView!
    var DrugInteractionDataSource: MEDListCollectionCell!
    var OpenType = "0";
    var selectedCell: Candidate? = nil
    var medArray = [String]()
    var searchArray = [String]()
    var medIDArray = [String]()
    var name = ""
    var medicineId = ""
    override func viewDidLoad() {
        //Load
        self.DrugCollectionView.isHidden = true
        
        searchBar.layer.cornerRadius = 15
        searchBar.layer.masksToBounds = true
        submitBtn.layer.cornerRadius = 8
        submitBtn.layer.masksToBounds = true
        noResultView.layer.cornerRadius = 8
        noResultView.layer.masksToBounds = true
        DrugCollectionView.layer.cornerRadius = 8
        DrugCollectionView.layer.masksToBounds = true
        DrugInteractionDataSource = MEDListCollectionCell()
        DrugCollectionView.dataSource = DrugInteractionDataSource
        self.noResultView.isHidden = true
        noResultLabel.text = "No search Result"
        
        DrugInteractionDataSource.onStartClick = {Candidate in
            self.onStartClick(Candidate: Candidate)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let value = CommonUtils.getJsonFromUserDefaults(forKey: Constants.number)
        
        if value == "1"{
            medIDArray = [""]
        }
    }
    
    
    func onStartClick(Candidate: Candidate)  {
        
        self.selectedCell = Candidate
        let value = self.selectedCell?.name
        
        if name == "" {
            
            let ConcatinateValue = name +  "\(String(describing: value ?? "")),"
            self.searchBar.text = ConcatinateValue
        }else {
            let ConcatinateValue = name + ","  +  "\(String(describing: value ?? "")),"
            self.searchBar.text = ConcatinateValue
        }
        
        //        name + (self.searchBar.text ?? "")na
       
        
        //        let ConcatinateValue = "," + (value ?? "")
        
        
        self.DrugCollectionView.isHidden = true
        
        medArray.append(self.selectedCell?.name ?? "")
        medIDArray.append(self.selectedCell?.rxcui ?? "")
        
        self.medicineId = medIDArray.joined(separator: " ")
        
        let medObj = self.medicineId
        
        let medID = self.selectedCell?.rxcui
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.medID2, withJson: medObj)
        
        
        //        self.searchBar.text = ""
        
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PAMAticleDetailViewScene") as! PAMAticleDetailViewController
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" {
            
            self.noResultView.isHidden = true
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.getMedValue, withJson: "")
                self.medArray = [""]
                self.name = ""
            
        }else {
            self.name = medArray.joined(separator: ",")
            
            var getMed = name + (self.searchBar.text ?? "")
            
//            if self.name.count == self.searchBar.text?.count {
//
//                let ali = self.name
//                self.noResultLabel.text = "Okay"
//
//
//
//            }else {
//
//                let ali = self.name
//                self.noResultLabel.text = "Wrong"
//            }
           
            if getMed == "" && getMed == "," {
                self.DrugCollectionView.isHidden = true
                return
            }else{
                
                self.DrugCollectionView.isHidden = false
                let splitted = getMed.components(separatedBy: ",")
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.getMedValue, withJson: splitted[splitted.endIndex - 1])
                getMed = name
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.GetMedName()
                }
                
            }
            
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        
        self.searchBar.text = ""
        
        self.name = ""
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.getMedValue, withJson: "")
            self.medArray = [""]
        
        let checkData = CommonUtils.getJsonFromUserDefaults(forKey: Constants.medID2)
        
        if checkData == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please Select Medicine")
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DrugDetailViewScene") as! DrugDetailViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func GetMedName() {
        
        var  parms = Dictionary<String, Any>()
        
        let value = CommonUtils.getJsonFromUserDefaults(forKey: Constants.getMedValue)
        
        parms["term"] = value;
        
        AF.request(Constants.DrugInterActionApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
//                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                    return
                }
                
                let drungInteractionModel = Mapper<DrungInteractionModel>().map(JSONString: response.value!) //JSON to model
                
                if drungInteractionModel != nil {
                    
                    if drungInteractionModel?.approximateGroup?.candidate == nil {
                        
                        self.noResultView.isHidden = false
                        self.DrugCollectionView.isHidden = true
                       
                        return
                    }else{
                        self.noResultView.isHidden = true
                        self.DrugCollectionView.isHidden = false
                        let List = drungInteractionModel?.approximateGroup?.candidate
                        
                        let filterData = List?.filter({$0.name != nil})
                        
                        self.DrugInteractionDataSource.setItems(items: filterData, openType: self.OpenType)
                        self.DrugCollectionView.reloadData()
                    }
                    
                } else {
                    
                    self.noResultView.isHidden = false
                    self.DrugCollectionView.isHidden = true
//                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
                
            })
    }
    
}

