//
//  SideMenuViewController.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 20/02/2022.
//

import UIKit
import Alamofire
import ObjectMapper

protocol SideMenuDelegate {
    func sideMenuOptionTapped(option: SpecialityTag)
}

enum ListItemMode: Int {
    case journal
    case video
    case gallery
    case msl
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var notifyIcon: UIView!
    var actionTapped: SideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allNotification()
        self.notifyIcon.isHidden = true
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        self.menuItemTapped(menu: SpecialityTag.init(rawValue: sender.tag) ?? .Gastroenterology)
    }
    
    @IBAction func notifyBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "notification", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationViewScene") as? NotificationViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func drugManualBtn(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "DrugManualScreen") as? DrugManualViewController
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    
    
    @IBAction func DolsBtn(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "DolsViewScene") as? DolsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func drugInteractionsBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Drug", bundle: Bundle.main).instantiateViewController(withIdentifier: "DrugInterActionViewScrene") as? DrugInterActionViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    private func menuItemTapped(menu: SpecialityTag) {
        if let action = actionTapped {
            action.sideMenuOptionTapped(option: menu)
            self.dismiss(animated: true, completion: nil)
        }
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
                            
                            let notiCount = CommonUtils.getJsonFromUserDefaults(forKey: Constants.notifyCount)
                            
                            if notificationModel?.data?.count == Int(notiCount) {
                                
                                self.notifyIcon.isHidden = true
                            }else {
                                
                                self.notifyIcon.isHidden = false
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
