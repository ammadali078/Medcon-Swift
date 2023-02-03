//
//  OnboardingPageView.swift
//  staerter-kit
//
//  Created by Muhammad Yawar Sohail on 22/06/2021.
//

import UIKit
import AlamofireImage

class OnboardingPageView: UIView {
    
    @IBOutlet weak var carouselImageView: UIImageView!
    private var page: OboardingCarouselModel!
    
    func set(page: OboardingCarouselModel) {
        self.page = page
        setImage()
    }
    
    private func setImage() {
        self.carouselImageView.contentMode = .scaleAspectFill
        carouselImageView.image = UIImage.init(named: page.imageName)
    }

}
