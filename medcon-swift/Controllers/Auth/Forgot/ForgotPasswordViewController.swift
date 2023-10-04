//
//  ForgotPasswordViewController.swift
//  medcon-swift
//
//  Created by Macbook on 26/08/2023.
//

import Foundation
import UIKit
import SwiftValidator
import Alamofire
import JGProgressHUD
import SwiftyGif
import ObjectMapper

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var emailTextField: MEDTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backView.layer.cornerRadius = 15
        self.backView.layer.masksToBounds = true
        
        self.submitBtn.layer.cornerRadius = 20
        self.submitBtn.layer.masksToBounds = true
        
        let myColor = UIColor.gray
        self.emailTextField.layer.cornerRadius = 8
        self.emailTextField.layer.borderWidth = 0.5
        self.emailTextField.layer.borderColor = myColor.cgColor
        self.emailTextField.layer.masksToBounds = true
       
    }
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        
        if emailTextField.text == "" {
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please enter your email")
            return
        }
        
        let getEmail = emailTextField.text
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.checkEmail, withJson: getEmail ?? "")
        
        let params: Parameters = [
            "Email": getEmail ?? "",
        ]
        
        AF.request(Constants.forgotApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
                    //                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                    return
                }
                
                let forgotModel = Mapper<NotificationModel>().map(JSONString: response.value!) //JSON to model
                
                if forgotModel != nil {
                    
                    if forgotModel?.success == true {
                        
                        
                        CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Medcon", withMessage: forgotModel?.message ?? "", onOkClicked: {() in
                            
                            
//                            let vc = UIStoryboard.init(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPViewScene") as? OTPViewController
//                            self.navigationController?.pushViewController(vc!, animated: true)
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Auth", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OTPViewScene") as! OTPViewController
                            self.present(nextViewController, animated:true, completion:nil)
                            
                                   
                            
                        })
                        
                    } else {
                        
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: forgotModel?.message ?? "")
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
            })
        
        
        
    }
    
}
    
