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
import FirebaseMessaging
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class AuthSignInViewController: UIViewController, MessagingDelegate {
    
    @IBOutlet weak var bgLogin: UIImageView!
    @IBOutlet weak var emailField: MEDTextField!
    @IBOutlet weak var passwordField: MEDTextField!
    @IBOutlet var textFields: [MEDTextField]!
    
    let validator = Validator()
    private let apiManager = APIManager.shared()
    let hud = JGProgressHUD()
    var token: String = "0"
    var token2: String = "0"
    var UserID: String = ""
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.UserID = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EmpId)
        
        Messaging.messaging().delegate = self
        
        Messaging.messaging().token { fcmToken, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let fcmToken = fcmToken {
            print("FCM registration token: \(fcmToken)")
              
              CommonUtils.saveJsonToUserDefaults(forKey: Constants.fcm, withJson: fcmToken)
//            self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
          }
        }
        
        ref = Database.database().reference()
       

        ref.child("version/ios/-NccAkdfQBlTQfxUCZrL").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let score = value?["version"] as? String ?? ""
                let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            
                if score == appVersion {
                   
                    print("ali")
                }else {
                    
                    CommonUtils.showMsgDialogWithupdate(showingPopupOn: self, withTitle: "Medcon", withMessage: "There is an Update available! Please update to use this App", onOkClicked: {() in
                        if let url = URL(string: "itms-apps://itunes.apple.com/app/medcon-2019/id1387008793") {
                            UIApplication.shared.open(url)
//                            self.token = "0"
//                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: self.token)
                        }
                    })
                    
                    
                }
            
                // ...
            }) { (error) in
                    print(error.localizedDescription)
        }
        
        self.token = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ammad)
        self.token2 = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ammad)

        if self.token == "1" {
            
            self.callLoginApi()
            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DolsViewScene") as! DolsViewController
//            self.present(nextViewController, animated:true, completion:nil)
         
        }else {
            self.setupValidations()
        }
        
//        Messaging.messaging().isAutoInitEnabled = true
        
//        Messaging.messaging().token { token, error in
//          if let error = error {
//            print("Error fetching FCM registration token: \(error)")
//          } else if let token = token {
//            print("FCM registration token: \(token)")
//            self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
//          }
//        }
        
       
        
        Messaging.messaging().isAutoInitEnabled = true

        
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      let userInfo = notification.request.content.userInfo

      Messaging.messaging().appDidReceiveMessage(userInfo)

      // Change this to your preferred presentation option
      completionHandler([[.alert , .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo

      Messaging.messaging().appDidReceiveMessage(userInfo)

      completionHandler()
    }

    func application(_ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
      Messaging.messaging().appDidReceiveMessage(userInfo)
      completionHandler(.noData)
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
        
        self.UserID = CommonUtils.getJsonFromUserDefaults(forKey: Constants.EmpId)
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
        
        self.token = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ammad)
       
        if self.token == "1" {
            
                let emailGet = CommonUtils.getJsonFromUserDefaults(forKey: Constants.checkEmail)
                
                let passGet = CommonUtils.getJsonFromUserDefaults(forKey: Constants.checkPass)
            if(emailGet == "" || passGet == ""){
                self.token = "0"
                
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: self.token)
            }else {
                
                let params: Parameters = ["Email": emailGet,
                                          "Password": passGet,
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
                        
                        if response.message == "Password is incorrect" {
                            self?.showToast(controller: self, message: response.message ?? "", seconds: 2)
                            self?.token = "0"
                            
                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: self?.token ?? "")
                            
                        }else {
                           
                                self?.showToast(controller: self, message: response.message ?? "", seconds: 2)
                            
                        }
                        
                      
                        
                        
                        
                    }else {
                        
                        self?.token = "1"
                        self?.token2 = "1"
                        
//                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: self?.token ?? "")
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: self?.token ?? "")
                        
                        AppUserManager.shared.user = registerResponse?.data
                        
                        let speciality = registerResponse?.data.user?.speciality
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.catId, withJson: String(speciality ?? 0))
                        
                        let empID = registerResponse?.data.user?.empID
                        
                        self?.UserID = "\(empID ?? 0)"
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.EmpId, withJson:  self?.UserID ?? "")
                        
                        guard let delegate = self?.view.window?.windowScene?.delegate as? SceneDelegate else { return }
                        
                        delegate.setupMainFlow()
                        
                    }
                    
                }
                
            }
                
             
            
        } else {
                
                let email = emailField.text
                let pass = passwordField.text
                
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.checkEmail, withJson: email ?? "")
                
                CommonUtils.saveJsonToUserDefaults(forKey: Constants.checkPass, withJson: pass ?? "")
                
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
                        
                        let speciality = registerResponse?.data.user?.speciality
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.catId, withJson: String(speciality ?? 0))
                        
                        let empID = registerResponse?.data.user?.empID
                        
                        self?.UserID = "\(empID ?? 0)"
                        
                        CommonUtils.saveJsonToUserDefaults(forKey: Constants.EmpId, withJson:  self?.UserID ?? "")
                        
                        guard let delegate = self?.view.window?.windowScene?.delegate as? SceneDelegate else { return }
                        
                        delegate.setupMainFlow()
                        
                    }
                    
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
