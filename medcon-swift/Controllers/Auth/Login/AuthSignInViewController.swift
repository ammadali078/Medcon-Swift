//
//  AuthSignInViewController.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 10/02/2022.
//

import UIKit
import SwiftValidator
import Alamofire
import JGProgressHUD
import SwiftyGif

class AuthSignInViewController: UIViewController {
    
    @IBOutlet weak var bgLogin: UIImageView!
    @IBOutlet weak var emailField: MEDTextField!
    @IBOutlet weak var passwordField: MEDTextField!
    @IBOutlet var textFields: [MEDTextField]!
    
    let validator = Validator()
    private let apiManager = APIManager.shared()
    let hud = JGProgressHUD()
    var token: String = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let getToken = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ammad)

        if getToken == "1" {
            
            callLoginssApi()
            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DolsViewScene") as! DolsViewController
//            self.present(nextViewController, animated:true, completion:nil)
         
        }else {
            setupValidations()
        }
        
    }
    
    private func setupValidations() {
        validator.registerField(emailField, errorLabel: emailField.errorLabel, rules: [RequiredRule()])
        validator.registerField(passwordField, errorLabel: passwordField.errorLabel, rules: [RequiredRule()])
    }
    
    @IBAction func submitActionButton(_ sender: Any) {
        removeAllErrorOnFields()
        validator.validate(self)
    }
    
    func removeAllErrorOnFields() {
        for item in textFields {
            item.layer.borderColor = AppDefaultTheme.shared.getColor(withName: .AppLightGrayTextFieldBorder).cgColor
            item.errorLabel.isHidden = true
        }
    }
}

extension AuthSignInViewController: ValidationDelegate {
    func validationSuccessful() {
        callLoginApi()
    }
    
    func showToast(controller: UIViewController?, message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        if let vc = controller {
            vc.present(alert, animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        removeAllErrorOnFields()
        for (field, error) in errors {
            if let field = field as? UITextField {
              field.layer.borderColor = UIColor.red.cgColor
            }
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.isHidden = false
          }
    }
    
}

extension AuthSignInViewController {
    
    
    private func callLoginApi() {
        let email = emailField.text
        let pass = passwordField.text
        
        let params: Parameters = ["Email": email ?? "",
                                  "Password": pass ?? "",
                                  "ContactNumber": "",
                                  "AuthToken": "",
                                  "DeviceType": 1,
                                  "RememberMe": 0,
                                  "device_id": (UIDevice.current.identifierForVendor != nil) ? UIDevice.current.identifierForVendor!.uuidString : "",
                                  "device_os": "IOS"]
        
        hud.show(in: self.view)
        self.apiManager.call(type: EndpointItem.login, params: params) { [weak self] (registerResponse: RegisterResponse?, asdsad: AlertMessage?) in
            self?.hud.dismiss()
            if let error = asdsad {
                self?.showToast(controller: self, message: error.body, seconds: 3)
            }
            else if let response = registerResponse, !response.success {
               
                
                self?.showToast(controller: self, message: response.message ?? "", seconds: 2)
            }
            else {
                
                
                self?.token = "1"
                
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: self?.token ?? "")
                
                AppUserManager.shared.user = registerResponse?.data
                
                guard let delegate = self?.view.window?.windowScene?.delegate as? SceneDelegate else { return }
                
                delegate.setupMainFlow()
                
            }
            
        }
    }
    
    private func callLoginssApi() {
        let email = emailField.text
        let pass = passwordField.text
        
        let params: Parameters = ["Email": email ?? "",
                                  "Password": pass ?? "",
                                  "ContactNumber": "",
                                  "AuthToken": "",
                                  "DeviceType": 1,
                                  "RememberMe": 0,
                                  "device_id": (UIDevice.current.identifierForVendor != nil) ? UIDevice.current.identifierForVendor!.uuidString : "",
                                  "device_os": "IOS"]
        
        hud.show(in: self.view)
        self.apiManager.call(type: EndpointItem.login, params: params) { [weak self] (registerResponse: RegisterResponse?, asdsad: AlertMessage?) in
            self?.hud.dismiss()
           
                
                self?.token = "1"
                
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: self?.token ?? "")
                
                AppUserManager.shared.user = registerResponse?.data
                
                guard let delegate = self?.view.window?.windowScene?.delegate as? SceneDelegate else { return }
                
                delegate.setupMainFlow()
                
        
            
        }
    }
}
