//
//  Extensions.swift
//  staerter-kit
//
//  Created by Muhammad Yawar Sohail on 22/06/2021.
//

import UIKit

// MARK: - Notifications
extension Notification.Name {
    /// Posted when the Current User changed, generic, could mean it was set or removed
    static let CurrentUserDidChange = Notification.Name("CurrentUserDidChange")
}

extension UIView
{
    static var nib: UINib
    {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static func instantiateFromNib() -> Self?
    {
        return nib.instantiate() as? Self
    }
    
    
    @IBInspectable var cornerRadiusValue: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}

extension UINib
{
    func instantiate() -> Any?
    {
        return instantiate(withOwner: nil, options: nil).first
    }
}

// MARK: - UIViewController Identifier
extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }

    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
