//
//  MEDTextField.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 10/02/2022.
//

import UIKit

class MEDTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 20)
    var errorLabel = UILabel()
    
    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
        // Add custom code here
        textFieldFont()
        firstTextFieldplaceHolder()
        setErrorLabel()
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func firstTextFieldplaceHolder() {
    }
    
    private func textFieldFont() {
    }
    
    func setUnderline() {
        for sub in self.subviews {
            sub.removeFromSuperview()
        }
        if underlineStyle == true {
            var bottomBorder = UIView()
            bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            bottomBorder.backgroundColor = AppDefaultTheme.shared.getColor(withName: .AppLightGrayTextFieldBorder)
            bottomBorder.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(bottomBorder)

            bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            bottomBorder.heightAnchor.constraint(equalToConstant: underlineHeight).isActive = true
            layoutIfNeeded()
        }
    }
    
    func setErrorLabel() {
        errorLabel.textColor = .red
        errorLabel.font = AppDefaultTheme.shared.getFont(withName: .AppLinkButtonText)
        errorLabel.isHidden = true
        self.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.snp.bottom)
        }
    }

    @IBInspectable var underlineStyle: Bool = false {
        didSet {
           setUnderline()
        }
    }

    @IBInspectable var underlineHeight: CGFloat = 0 {
        didSet {
            setUnderline()
        }
    }
}
