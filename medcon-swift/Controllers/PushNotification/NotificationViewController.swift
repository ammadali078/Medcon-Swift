//
//  NotificationViewController.swift
//  medcon-swift
//
//  Created by Macbook on 15/08/2023.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class NotificationViewController: UIViewController{
    
    @IBOutlet weak var notifyCollectionViewOutlet: UICollectionView!
    
    var OpenType = "0";
    var NotifyListDataSource: NotifyCollectionCell!
    
    override func viewDidLoad() {
        
        navigationItem.title = "Notifications"
        
        NotifyListDataSource = NotifyCollectionCell()
        notifyCollectionViewOutlet.dataSource = NotifyListDataSource
        
        self.allNotification()
        
    }
    
    
    func allNotification(){
        
        var  parms = Dictionary<String, Any>()
        
        parms["page"] = 1;
        
        AF.request(Constants.getNotification, method: .get, parameters: parms, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                
                    //On Dialog Close
                    if (response.error != nil) {
//                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                        return
                    }
                    
                    let notificationModel = Mapper<NotificationModel>().map(JSONString: response.value!) //JSON to model
                    
                    if notificationModel != nil {
                        
                        if notificationModel?.success == true {
                            
                            
                            let List = notificationModel?.data
                            
                            let count = notificationModel?.data?.count
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.notifyCount, withJson: String(count ?? 0))
                            
                            self.NotifyListDataSource.setItems(items: List, openType: self.OpenType)
                            self.notifyCollectionViewOutlet.reloadData()
                            
                            
                        } else {
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "inValid")
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                    }
                })
    }
    
}
