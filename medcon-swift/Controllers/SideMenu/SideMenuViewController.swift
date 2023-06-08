//
//  SideMenuViewController.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 20/02/2022.
//

import UIKit

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
    
    var actionTapped: SideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        self.menuItemTapped(menu: SpecialityTag.init(rawValue: sender.tag) ?? .Gastroenterology)
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
}
