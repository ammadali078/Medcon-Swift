//
//  AuthSignUpViewController.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 12/02/2022.
//

import UIKit
import SwiftValidator
import Alamofire
import JGProgressHUD
import iOSDropDown

class AuthSignUpViewController: UIViewController {

    @IBOutlet weak var emailField: MEDTextField!
    @IBOutlet weak var fulNameField: MEDTextField!
    @IBOutlet weak var passwordField: MEDTextField!
    @IBOutlet weak var confirmPasswordField: MEDTextField!
    @IBOutlet weak var uniqueCode: MEDTextField!
    @IBOutlet weak var city: MEDTextField!
    @IBOutlet weak var tncAcceptButton: UIButton!
    @IBOutlet var textFields: [MEDTextField]!
    @IBOutlet weak var dropDown : DropDown!
    
    let validator = Validator()
    private let apiManager = APIManager.shared()
    let hud = JGProgressHUD()
    var selectedSpeciality = "Miscellaneous"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupValidations()
        
        setupDropDown()
    }
    
    private func setupValidations() {
        validator.registerField(emailField, errorLabel: emailField.errorLabel, rules: [RequiredRule(), EmailRule()])
        validator.registerField(uniqueCode, errorLabel: uniqueCode.errorLabel, rules: [RequiredRule(),])
        validator.registerField(passwordField, errorLabel: passwordField.errorLabel, rules: [RequiredRule(), PasswordRule(), MinLengthRule(length: 8)])
       
        validator.registerField(confirmPasswordField, errorLabel: confirmPasswordField.errorLabel, rules: [RequiredRule(), PasswordRule(), MinLengthRule(length: 8), ConfirmationRule(confirmField: passwordField, message: "Confirm password doesn't match")])
//        validator.registerField(city, errorLabel: city.errorLabel, rules: [RequiredRule()])
    }
    
    private func setupDropDown() {
        dropDown.optionArray = ["GASTROENTEROLOGY",
                                "MEN & WOMEN HEALTH",
                                "RESPIRATORY",
                                "PEDIATRICS",
                                "PAIN",
                                "CNS",
                                "GENERAL HEALTH"]
        
        dropDown.optionIds = [0,1,2,3,4,5,6]
        dropDown.selectedIndex = 0
        dropDown.didSelect{[weak self] (selectedText , index ,id) in
            self?.selectedSpeciality = selectedText
            
            let selectedSP = self?.selectedSpeciality
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.selectSP, withJson: selectedSP ?? "")
        }
        
        dropDown.inputView = UIView()
        dropDown.inputAccessoryView = UIView()
        dropDown.tintColor = .white
    }
    
    @IBAction func submitActionButton(_ sender: Any) {
        
        if dropDown.text == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please Select Your Speciality")
            return
        }
        
        removeAllErrorOnFields()
        validator.validate(self)
    }
    
    @IBAction func tncButton(_ sender: Any) {
        tncAcceptButton.isSelected = !tncAcceptButton.isSelected
    }
    
    func removeAllErrorOnFields() {
        for item in textFields {
            item.layer.borderColor = AppDefaultTheme.shared.getColor(withName: .AppLightGrayTextFieldBorder).cgColor
            item.errorLabel.isHidden = true
        }
    }
}

extension AuthSignUpViewController: ValidationDelegate {
    func validationSuccessful() {
        if tncAcceptButton.isSelected {
            callRegisterApi()
        }
        else {
            self.showToast(controller: self, message: "Please accept T&C's", seconds: 3)
        }
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

extension AuthSignUpViewController {
    private func callRegisterApi() {
        
        if selectedSpeciality == "" {
            
            CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "Medcon", withMessage: "Please Select Your Speciality")
            return
        }
        
        let email = emailField.text
        let UniqueCode = uniqueCode.text
        let pass = passwordField.text
//        let City = city.text
//        let name = fulNameField.text
        
        
//                                  "FirstName": name ?? "",
        
        
//                                  "city": City ?? "",
        
        let params: Parameters = ["Email": email ?? "",
                                  "Password": pass ?? "",
                                  "Speciality": 0,
                                  "SpecialityName": selectedSpeciality,
                                  "RegistrationCode": UniqueCode ?? "",
                                  "DeviceType": 1,
                                  "device_id": (UIDevice.current.identifierForVendor != nil) ? UIDevice.current.identifierForVendor!.uuidString : "",
                                  "Status": 1,
                                  "device_os": "IOS"]
        hud.show(in: self.view)
        self.apiManager.call(type: EndpointItem.register, params: params) { [weak self] (registerResponse: RegisterResponse?, asdsad: AlertMessage?) in
            self?.hud.dismiss()
            if let error = asdsad {
                self?.showToast(controller: self, message: error.body, seconds: 3)
            }
            else if let response = registerResponse, !response.success {
                self?.showToast(controller: self, message: registerResponse?.message ?? "", seconds: 2)
            }
            else {
                AppUserManager.shared.user = registerResponse?.data
                
                guard let delegate = self?.view.window?.windowScene?.delegate as? SceneDelegate else { return }
                
                delegate.setupMainFlow()
                
            }
            
        }
    }
}
