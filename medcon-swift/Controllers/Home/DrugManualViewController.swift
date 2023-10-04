//
//  DrugManualViewController.swift
//  medcon-swift
//
//  Created by Ccomputing on 08/09/2022.
//

import Foundation
import UIKit
import ObjectMapper

class DrugManualViewController: UIViewController {
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var brandNameCollectionView: UICollectionView!
    
    var bannerListDataSource: BrandCollectionViewCell!
    var getBrandName:[GetAllBrandData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerListDataSource = BrandCollectionViewCell()
        brandNameCollectionView.dataSource = bannerListDataSource
        
        var data = CommonUtils.getJsonFromUserDefaults(forKey: Constants.saveBrandData)
        
        if (data == "") {data = "[]"}
        self.getBrandName = Mapper<GetAllBrandData>().mapArray(JSONString: data)!
        
        
        let btn1 = "0"
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.btn, withJson: btn1)
        
        navigationItem.title = "Drug Manual"
        
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
        
        searchBar.attributedPlaceholder = NSAttributedString(
            string: "  Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]

        )
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
    
    @IBAction func btnGeneric(_ sender: Any) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.btn, withJson: "1")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewscreen") as! DetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnIndex(_ sender: Any) {
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.btn, withJson: "2")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewscreen") as! DetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBrands(_ sender: Any) {
        
        self.showToast(controller: self, message: "Coming Soon", seconds: 2)
        
//            CommonUtils.saveJsonToUserDefaults(forKey: Constants.btn, withJson: "3")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewscreen") as! DetailViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func AboutBtn(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutDrugManualScene") as! AboutDrugManualViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
//
//    @IBAction func drugInteractionTool(_ sender: Any) {
//
//        CommonUtils.saveJsonToUserDefaults(forKey: Constants.btn, withJson: "4")
//    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewscreen") as! DetailViewController
//    self.navigationController?.pushViewController(vc, animated: true)
//
//    }
    
    
    
    @IBAction func btnBck(_ sender: Any) {
        
    }
    
    
    
//    @IBAction func btnDolsClick(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DolsViewScene") as! DolsViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
   
}
