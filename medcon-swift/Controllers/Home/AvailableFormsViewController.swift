//
//  AvailableFormsViewController.swift
//  medcon-swift
//
//  Created by macbook on 15/09/2022.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class AvailableFormsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
    
    @IBOutlet weak var AvailableFormsCollectionView: UICollectionView!
    @IBOutlet weak var availableFormsSeg: UISegmentedControl!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var DetailtextView2: UITextView!
    @IBOutlet weak var AvailableFormTableView: UITableView!
    var seg = 0
    var availableListDataSource: AvailableFormCell!
    var OpenType = "0";
    var ApiResult : AvailableData? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        availableListDataSource = AvailableFormCell()
        AvailableFormsCollectionView.dataSource = availableListDataSource
        
        AvailableFormsCollectionView.isHidden = true
        AvailableApi()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableFormTableCell", for: indexPath) as! AvailableFormListCell
        
        if indexPath.row == 0 {
            cell.detailLabelView.text = ApiResult?.indications_and_dose
        }else if indexPath.row == 1 {
            cell.detailLabelView.text = ApiResult?.contraindications
        }else{
            cell.detailLabelView.text = ApiResult?.side_effects
        }
        
        return cell
    }
    
    
    
    @IBAction func segFroms(_ sender: Any) {
        switch availableFormsSeg.selectedSegmentIndex{
        case 0 :
            detailTextView.isHidden = false
            DetailtextView2.isHidden = false
            AvailableFormTableView.isHidden = false
            AvailableFormsCollectionView.isHidden = true
        case 1 :
                detailTextView.isHidden = true
                DetailtextView2.isHidden = true
            AvailableFormTableView.isHidden = true
                AvailableFormsCollectionView.isHidden = false
        default:
            break
        }
    }
    
    func AvailableApi(){
        
        let selId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selId)
        
            var  parms = Dictionary<String, String>()
                
            parms["token"] = "85677466274605";
            parms["id"] = selId;
            
            AF.request(Constants.DetailAvailableApi, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
                .responseString(completionHandler: {(response) in
                    // On Response
                        
                        //On Dialog Close
                        if (response.error != nil) {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                            return
                        }
                        
                        let availableModel = Mapper<AvailableModel>().map(JSONString: response.value!) //JSON to model
                        
                        if availableModel != nil {
                            
                            if availableModel?.status == "success" {
                                
                                self.ApiResult = availableModel?.data
                                
                                self.AvailableFormTableView.reloadData()
                                
                                self.detailTextView.attributedText = availableModel?.data?.indications_and_dose?.htmlToAttributedString
                                self.DetailtextView2.attributedText = availableModel?.data?.contraindications?.htmlToAttributedString
                                
//                                self.detailTextView.attributedText = NSMutableAttributedString(string: "\(String(describing: availableModel?.data?.indications_and_dose?.htmlToAttributedString)) \(String(describing: availableModel?.data?.contraindications?.htmlToAttributedString)) \(String(describing: availableModel?.data?.side_effects?.htmlToAttributedString)) \(String(describing: availableModel?.data?.precautions?.htmlToAttributedString))")
                                
                                let List = availableModel?.data?.forms
                                
                                self.availableListDataSource.setItems(items: List, openType: self.OpenType)
                                self.AvailableFormsCollectionView.reloadData()
                                
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

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
