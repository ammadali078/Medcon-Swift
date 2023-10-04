//
//  OTPViewController.swift
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
import AEOTPTextField
import ObjectMapper

class OTPViewController: UIViewController, AEOTPTextFieldDelegate {
    
    
    func didUserFinishEnter(the code: String) {
        
    }
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var otpTextField: AEOTPTextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpTextField.otpDelegate = self
        otpTextField.configure(with: 4)
        
        self.backView.layer.cornerRadius = 15
        self.backView.layer.masksToBounds = true
        
        let email = CommonUtils.getJsonFromUserDefaults(forKey: Constants.checkEmail)
        emailLabel.text = email
        
    }
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        
        if otpTextField.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Check your email for the OTP")
            return
        }
       
        let getEmail = CommonUtils.getJsonFromUserDefaults(forKey: Constants.checkEmail)
        let otpText = otpTextField.text
        
//        CommonUtils.saveJsonToUserDefaults(forKey: Constants.checkEmail, withJson: getEmail ?? "")
        
        let params: Parameters = [
            "Email": getEmail ,
            "OtpCode": otpText ?? "",
        ]
        
        AF.request(Constants.oTPApi, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
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
                            
                            let getToken = oTPModel?.data?.Tokencode
                            
                            print("ammad",getToken ?? "")
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.OTPtoken, withJson: getToken ?? "")
                        
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Auth", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreatePasswordViewScene") as! CreatePasswordViewController
                            self.present(nextViewController, animated:true, completion:nil)
                            
                        })
                        
                    } else {
                        
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: oTPModel?.message ?? "")
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
            })
        

        
    }
    
    
}

