//
//  CreatePasswordViewController.swift
//  medcon-swift
//
//  Created by Macbook on 27/08/2023.
//

import Foundation
import UIKit
import SwiftValidator
import Alamofire
import JGProgressHUD
import SwiftyGif
import ObjectMapper

class CreatePasswordViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var passwordTextField: MEDTextField!
    @IBOutlet weak var confromPasswordTetField: MEDTextField!
    var token: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backView.layer.cornerRadius = 15
        self.backView.layer.masksToBounds = true
        
        let myColor = UIColor.gray
        self.passwordTextField.layer.cornerRadius = 8
        self.passwordTextField.layer.borderWidth = 0.5
        self.passwordTextField.layer.borderColor = myColor.cgColor
        self.passwordTextField.layer.masksToBounds = true
        
        self.confromPasswordTetField.layer.cornerRadius = 8
        self.confromPasswordTetField.layer.borderWidth = 0.5
        self.confromPasswordTetField.layer.borderColor = myColor.cgColor
        self.confromPasswordTetField.layer.masksToBounds = true
        
    }
    @IBAction func submitBtn(_ sender: Any) {
        
        if self.passwordTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please enter your new password")
            return
        }
        if self.confromPasswordTetField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please re-enter your password")
            return
        }
        
        let password = passwordTextField.text
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.checkPass, withJson: password ?? "")
        let confromPass = confromPasswordTetField.text
        let getEmail = CommonUtils.getJsonFromUserDefaults(forKey: Constants.checkEmail)
        let token = CommonUtils.getJsonFromUserDefaults(forKey: Constants.OTPtoken)
        
        print("ammad",token)
        if password == confromPass {
            
            let params: Parameters = [
                "Email": getEmail ,
                "Password": password ?? "",
                "ConfirmPassword": confromPass ?? "",
                "Code": token ,
            ]
            
            AF.request(Constants.createPasswordApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .responseString(completionHandler: {(response) in
                    // On Response
                    
                    //On Dialog Close
                    if (response.error != nil) {
                        //                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please connect to internet and try again")
                        return
                    }
                    
                    let oTPModel = Mapper<OTPModel>().map(JSONString: response.value!) //JSON to model
                    
                    if oTPModel != nil {
                        
                        if oTPModel?.success == true {
                            
                            CommonUtils.showMsgDialogWithOk(showingPopupOn: self, withTitle: "Medcon", withMessage: oTPModel?.message ?? "", onOkClicked: {() in
                                
                                self.token = "1"
                                
                                CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: self.token)
                            
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Auth", bundle:nil)
                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AuthSignInViewController") as! AuthSignInViewController
                                self.present(nextViewController, animated:true, completion:nil)
                                
                            })
                            
                        } else {
                            
                            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: oTPModel?.message ?? "")
                        }
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                    }
                })
            
        }else{
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Passwords did not match")
            
        }
       
        
      
        
        
    }
    
}
