//
//  PAMAticleDetailViewController.swift
//  medcon-swift
//
//  Created by Macbook on 04/05/2023.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class PAMAticleDetailViewController: UIViewController{
    @IBOutlet weak var articleDetailImageView: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleAdditionalDes: UILabel!
    
    override func viewDidLoad() {
        
        let checkIds = CommonUtils.getJsonFromUserDefaults(forKey: Constants.checkID)
        
        if checkIds == "1" {
            
            self.getPopularDetail()
            
        }else{
        
        let title = CommonUtils.getJsonFromUserDefaults(forKey: Constants.getTitle)
        let html = CommonUtils.getJsonFromUserDefaults(forKey: Constants.getHtml)
        
        self.articleTitle.text = title
        
        self.articleDescription.attributedText = html.htmlToAttributedStringHTmlARTDetail
        
        DispatchQueue.main.async {
            
            let baseUrl = "http://medcon-beta.digitrends.pk"
            
            let img = CommonUtils.getJsonFromUserDefaults(forKey: Constants.getImg)
            
            var urlString = img.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            self.articleDetailImageView.sd_setImage(with: URL(string: "\(baseUrl)\(urlString)"), completed: nil)
            
        }
            
        }
        
    }
    
    
    func getPopularDetail() {
        
        var  parms = Dictionary<String, Any>()
        
        let artId = CommonUtils.getJsonFromUserDefaults(forKey: Constants.PopularID)
        
        parms["articleid"] = artId;
        
        AF.request(Constants.getPopArtDetail, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                
                //On Dialog Close
                if (response.error != nil) {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    return
                }
                
                let popularDetailModel = Mapper<PopularDetailModel>().map(JSONString: response.value!) //JSON to model
                
                if popularDetailModel != nil {
                    
                    if popularDetailModel?.success == true {
                        
                        
                        let title = popularDetailModel?.data?.title
                        let html = popularDetailModel?.data?.html
                        
                        self.articleTitle.text = title
                        
                        self.articleDescription.attributedText = html?.htmlToAttributedStringHTmlARTDetail
                        
                        DispatchQueue.main.async {
                            
                            let baseUrl = "http://medcon-beta.digitrends.pk"
                            
                            let img = popularDetailModel?.data?.imageUrl
                            
                            var urlString = img?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                            
                            self.articleDetailImageView.sd_setImage(with: URL(string: "\(baseUrl)\(urlString)"), completed: nil)
                            
                        }
                        
                        
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
    var htmlToAttributedStringHTmlARTDetail : NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToStringObjectART : String {
        return htmlToAttributedStringHTmlARTDetail?.string ?? ""
    }
}
