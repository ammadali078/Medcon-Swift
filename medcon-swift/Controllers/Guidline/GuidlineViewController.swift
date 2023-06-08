//
//  GuidlineViewController.swift
//  medcon-swift
//
//  Created by Macbook on 08/06/2023.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

class GuidlineViewController: UIViewController{
    
    override func viewDidLoad() {
         
    }
    
    @IBAction func boxBtn1(_ sender: Any) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.boxNumber, withJson: "1")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GuidlineDetailViewScene") as! GuidlineDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func boxBtn2(_ sender: Any) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.boxNumber, withJson: "2")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GuidlineDetailViewScene") as! GuidlineDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func boxBtn3(_ sender: Any) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.boxNumber, withJson: "3")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GuidlineDetailViewScene") as! GuidlineDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func boxBtn4(_ sender: Any) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.boxNumber, withJson: "4")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GuidlineDetailViewScene") as! GuidlineDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func boxBtn5(_ sender: Any) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.boxNumber, withJson: "5")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GuidlineDetailViewScene") as! GuidlineDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func boxBtn6(_ sender: Any) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.boxNumber, withJson: "6")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GuidlineDetailViewScene") as! GuidlineDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

