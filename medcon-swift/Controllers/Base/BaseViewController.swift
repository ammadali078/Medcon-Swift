//
//  BaseViewController.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 12/02/2022.
//

import UIKit
import SideMenu
import Alamofire
import FittedSheets

class BaseViewController: UIViewController, SideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let count = self.navigationController?.viewControllers.count {
            configureLeftButton(isBack: count > 1)
        }
    }
    
    func setTitle(withText text: String) {
        self.title = text
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: AppDefaultTheme.shared.getFont(withName: .ScreenTitleFont)]
    }
    
    @IBAction func didTouchHamButton(_ sender: Any) {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            return
        }
        
        let sideMenu: SideMenuNavigationController = UIStoryboard(storyboard: .main).instantiateVC()
        sideMenu.leftSide = false
        
        let sideMenuController: SideMenuViewController = UIStoryboard(storyboard: .main).instantiateVC()
        sideMenuController.actionTapped = self
        sideMenu.setViewControllers([sideMenuController], animated: true)
        self.present(sideMenu, animated: true, completion: nil)
    }
    
    @IBAction func didTouchBackButton(_ sender: Any) {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            self.navigationController?.popViewController(animated: true)
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
    
    // configure left button in navigation bar
    func configureLeftButton(isBack: Bool) {
            
        let hamButton = UIButton(type: .custom)
        let HamImageName = isBack ? "back-arrow" : "medcon-tabbar-icon"
        hamButton.setImage(UIImage(named: HamImageName), for: .normal)
        hamButton.addTarget(self, action: #selector(didTouchBackButton(_:)), for: .touchUpInside)
        hamButton.imageEdgeInsets = UIEdgeInsets(top: -2, left: 0, bottom: -1, right: 0)
        hamButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 8, right: 0)
        hamButton.sizeToFit()
        
        // create custom left bar button item
        let leftBarButtonItem = UIBarButtonItem(customView: hamButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        configureRightButton()
    }
    
    // configure right button in navigation bar
    func configureRightButton() {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            let hamButton = UIButton(type: .custom)
            let HamImageName =  "SGhNNT"
            hamButton.setImage(UIImage(named: HamImageName), for: .normal)
//            hamButton.addTarget(self, action: #selector(didTouchHamButton(_:)), for: .touchUpInside)
            hamButton.imageEdgeInsets = UIEdgeInsets(top: -2, left: 0, bottom: -1, right: -20)
            hamButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 8, right: 0)
            hamButton.sizeToFit()
            
            // create custom left bar button item
            let rightBarButtonItem = UIBarButtonItem(customView: hamButton)
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }else {
            
            let hamButton = UIButton(type: .custom)
            let HamImageName =  "hamburger"
            hamButton.setImage(UIImage(named: HamImageName), for: .normal)
            hamButton.addTarget(self, action: #selector(didTouchHamButton(_:)), for: .touchUpInside)
            hamButton.imageEdgeInsets = UIEdgeInsets(top: -2, left: 0, bottom: -1, right: 0)
            hamButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            hamButton.sizeToFit()
            
            // create custom left bar button item
            let rightBarButtonItem = UIBarButtonItem(customView: hamButton)
            navigationItem.rightBarButtonItem = rightBarButtonItem
            
        }
            
      
    }
    
//    func configureRightImage() {
//        if let count = self.navigationController?.viewControllers.count, count < 1 {
//            return
//        }
//
//
//    }
    
    func optionChanged(option: SpecialityTag) {
        
    }
    
    func openSheet() {
        
    }
    
    func sideMenuOptionTapped(option: SpecialityTag) {
        if (option == .LOGOUT) {
            
           let token = "0"
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: token)
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.checkEmail, withJson: "")
            
            CommonUtils.saveJsonToUserDefaults(forKey: Constants.checkPass, withJson: "")
            
            guard let delegate = self.view.window?.windowScene?.delegate as? SceneDelegate else { return }
            delegate.logOutUser()
        }
        else if (option == .ContactUs) {
            openSheet()
        }
        else {
            optionChanged(option: option)
        }
    }
}
