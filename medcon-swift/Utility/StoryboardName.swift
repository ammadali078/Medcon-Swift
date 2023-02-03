//
//  StoryboardName.swift
//  staerter-kit
//
//  Created by Muhammad Yawar Sohail on 22/06/2021.
//

import UIKit

enum StoryboardName: String {
    
    case main = "Main"
    case onboarding = "Onboarding"
    case auth = "Auth"
    case home = "Home"

    static func `for`(_ storyboard: StoryboardName) -> String {
        return storyboard.rawValue
    }
}

// MARK: - UIStoryboard name & ViewController Instantiation function
extension UIStoryboard {
    convenience init(storyboard: StoryboardName, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateVC<VC: UIViewController>() -> VC {
        guard let viewController = instantiateViewController(withIdentifier: VC.identifier) as? VC else {
            fatalError("Couldn't instantiate viewController with identifier \(VC.identifier)")
        }
        return viewController
    }
}
