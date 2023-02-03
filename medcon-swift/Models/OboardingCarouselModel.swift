//
//  OboardingCarouselModel.swift
//  staerter-kit
//
//  Created by Muhammad Yawar Sohail on 22/06/2021.
//

import Foundation

struct OboardingCarouselModel {
    var title: String = ""
    var descriptionText: String = ""
    var imageName: String = ""
    
    init(title: String, desc: String, img: String) {
        self.title = title
        self.descriptionText = desc
        self.imageName = img
    }
}
