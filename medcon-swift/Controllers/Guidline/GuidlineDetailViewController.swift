//
//  GuidlineDetailViewController.swift
//  medcon-swift
//
//  Created by Macbook on 08/06/2023.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class GuidlineDetailViewController: UIViewController{
    
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        
        self.getArtDetail()
        
        self.titleView.layer.cornerRadius = 8
        self.titleView.layer.masksToBounds = true
        
    }
    
    func getArtDetail() {
        
        var  parms = Dictionary<String, Any>()
        
        let value = CommonUtils.getJsonFromUserDefaults(forKey: Constants.getMedValue)
        
        parms["term"] = "";
        
        AF.request(Constants.getArticleDetail, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
//                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                    return
                }
                
                let guidlineDetailModel = Mapper<GuidlineDetailModel>().map(JSONString: response.value!) //JSON to model
                
                if guidlineDetailModel != nil {
                    
                    let checkBox = CommonUtils.getJsonFromUserDefaults(forKey: Constants.boxNumber)
                    
                    if checkBox == "1" {
                        
                        DispatchQueue.main.async {
                            
                            self.titleLabel.text = guidlineDetailModel?.data?[0].guidelines?[0].title
                            self.titleLabel2.text = guidlineDetailModel?.data?[0].guidelines?[0].title
                            self.detailLabel.attributedText = guidlineDetailModel?.data?[0].guidelines?[0].html?.htmlToAttributedStringHTmlDetail
                        }
                        
                    }else if checkBox == "2" {
                        
                        DispatchQueue.main.async {
                            
                            self.titleLabel.text = guidlineDetailModel?.data?[0].guidelines?[1].title
                            self.titleLabel2.text = guidlineDetailModel?.data?[0].guidelines?[1].title
                            self.detailLabel.attributedText = guidlineDetailModel?.data?[0].guidelines?[1].html?.htmlToAttributedStringHTmlDetail
                            
                        }
                        
                    }else if checkBox == "3" {
                        
                        DispatchQueue.main.async {
                            
                            self.titleLabel.text = guidlineDetailModel?.data?[0].guidelines?[2].title
                            self.titleLabel2.text = guidlineDetailModel?.data?[0].guidelines?[2].title
                            self.detailLabel.attributedText = guidlineDetailModel?.data?[0].guidelines?[2].html?.htmlToAttributedStringHTmlDetail
                        }
                        
                    }else if checkBox == "4" {
                        
                        DispatchQueue.main.async {
                            
                            self.titleLabel.text = guidlineDetailModel?.data?[0].guidelines?[3].title
                            self.titleLabel2.text = guidlineDetailModel?.data?[0].guidelines?[3].title
                            self.detailLabel.attributedText = guidlineDetailModel?.data?[0].guidelines?[3].html?.htmlToAttributedStringHTmlDetail
                            
                        }
                        
                    }else if checkBox == "5" {
                        
                        DispatchQueue.main.async {
                            
                            self.titleLabel.text = guidlineDetailModel?.data?[0].guidelines?[4].title
                            self.titleLabel2.text = guidlineDetailModel?.data?[0].guidelines?[4].title
                            self.detailLabel.attributedText = guidlineDetailModel?.data?[0].guidelines?[4].html?.htmlToAttributedStringHTmlDetail
                            
                        }
                        
                    }else if checkBox == "6" {
                        
                        DispatchQueue.main.async {
                            
                            self.titleLabel.text = guidlineDetailModel?.data?[0].guidelines?[5].title
                            self.titleLabel2.text = guidlineDetailModel?.data?[0].guidelines?[5].title
                            self.detailLabel.attributedText = guidlineDetailModel?.data?[0].guidelines?[5].html?.htmlToAttributedStringHTmlDetail
                            
                        }
                        
                    }
                    
                    
                } else {
                    
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "something went wrong")
                }
                
            })
    }
    
}
extension String {
    var htmlToAttributedStringHTmlDetail : NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToStringObjectDetail : String {
        return htmlToAttributedStringHTml?.string ?? ""
    }
}
