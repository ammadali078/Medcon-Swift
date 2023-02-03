//
//  AticleDetailViewController.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 26/02/2022.
//

import UIKit
import Alamofire
import JGProgressHUD

class AticleDetailViewController: BaseViewController {
    @IBOutlet weak var specialityTitle: UILabel!
    @IBOutlet weak var specialityBannerTitle: UILabel!
    @IBOutlet weak var specialityIcon: UIImageView!
    @IBOutlet weak var specialityBanner: UIImageView!
    @IBOutlet weak var specialityTitleBackground: UIView!
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleAdditionalDescription: UILabel!
    @IBOutlet weak var articleView: UIView!
    @IBOutlet weak var articleLabel: UILabel!
    
    var dataSource: ArticleTableViewCellDataSource?
    var selectedSpeciality: SpecialityTag = .Gastroenterology
    
    private let apiManager = APIManager.shared()
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(withText: "FULL ARTICLE")
        setupUI()
        articleView.layer.cornerRadius = 12
        articleView.layer.masksToBounds = true
        articleImage.layer.cornerRadius = 8
        articleImage.layer.masksToBounds = true
        articleView.backgroundColor = selectedSpeciality.titleBackgroundColor.withAlphaComponent(0.3)
        articleLabel.textColor = selectedSpeciality.titleBackgroundColor
        
        
    }
    
    private func setupUI() {
        specialityTitle.text = selectedSpeciality.titleString
        specialityIcon.image = UIImage(named: selectedSpeciality.iconName)
        specialityBanner.image = UIImage(named: selectedSpeciality.bannerName)
        specialityBannerTitle.text = selectedSpeciality.bannerTitleString
        specialityTitleBackground.backgroundColor = selectedSpeciality.titleBackgroundColor
        
        guard let ds = dataSource else { return }
        articleTitle.text = ds.getTitleText()
//        articleLabel.text =
        articleDescription.attributedText = ds.getHtmlText().htmlToAttributedString
        articleAdditionalDescription.text = ds.getReferenceDetails()
        articleLabel.text = ds.getTypeText()
        
        if let url = URL.init(string: ds.getImageUrl()) {
            articleImage.af.setImage(withURL: url)
        }
    }
    
    @IBAction func requestArticleButton(sender: UIButton) {
        let refreshAlert = UIAlertController(title: "Request For Article", message: "Are you sure you want to get the full article?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] (action: UIAlertAction!) in
            self?.callRequestApi()
          }))

        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
          
          }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    func callRequestApi() {
        guard let ds = dataSource else { return }
        let params: Parameters = ["articleName": ds.getTitleText()]
        hud.show(in: self.view)
        self.apiManager.call(type: EndpointItem.sendEmail, params: params) { [weak self] (response: SendEmailResponse?, asdsad: AlertMessage?) in
            self?.hud.dismiss()
            if let error = asdsad {
                self?.showToast(controller: self, message: error.body, seconds: 3)
            }
            else if let response = response, !response.status {
                self?.showToast(controller: self, message: response.message, seconds: 2)
            }
            else {
                self?.showToast(controller: self, message: "Success", seconds: 2)
            }
            
        }
    }
}
