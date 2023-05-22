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
    
//    let baseUrl = "http://medcon-beta.digitrends.pk"
    
    override func viewDidLoad() {
        
//        self.getArticleDetail()
        
        let articelImage = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selImg)
        let artTitle = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selTitle)
        let articleDes = CommonUtils.getJsonFromUserDefaults(forKey: Constants.selDes)

        let baseUrl = "http://medcon-beta.digitrends.pk"

        var urlString = articelImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

            let url = URL(string: baseUrl + urlString)

            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch

        self.articleDetailImageView.image = UIImage(data: data!)

        self.articleTitle.text = artTitle
        self.articleDescription.attributedText = articleDes.htmlToAttributedStringDetailHtml
        
    }
    
//    func getArticleDetail() {
//
//        let artID = CommonUtils.getJsonFromUserDefaults(forKey: Constants.cellID)
//
//            var  parms = Dictionary<String, Any>()
//
//            parms["articleid"] = artID;
//
//            AF.request(Constants.getARTDetail, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
//                .responseString(completionHandler: {(response) in
//                    // On Response
//
//                    //On Dialog Close
//                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
//                        return
//                    }
//
//                    let artDetailModel = Mapper<ArtDetailModel>().map(JSONString: response.value!) //JSON to model
//
//                    if artDetailModel != nil {
//
//                        if artDetailModel?.success == true {
//
//                            self.articleTitle.attributedText = artDetailModel?.data?.html?.htmlToAttributedStringDetailHtml
//
//
//                        } else {
//                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
//                        }
//                    } else {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
//                    }
//
//                })
//
//    }
    
}
extension String {
    var htmlToAttributedStringDetailHtml : NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToStringDetailHtml : String {
        return htmlToAttributedStringDetailHtml?.string ?? ""
    }
}
