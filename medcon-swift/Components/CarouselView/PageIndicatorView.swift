//
//  PageIndicatorView.swift
//  staerter-kit
//
//  Created by Muhammad Yawar Sohail on 22/06/2021.
//

import UIKit
import SnapKit

class PageIndicatorView: UIView {
    
    var dots = [UIView]()
    var selectedIndex: Int = 0 {
        didSet {
            if dots.isEmpty  || selectedIndex == oldValue { return }
            
            if selectedIndex < dots.count && selectedIndex >= 0 {
                let selectedDotView: UIView = dots[selectedIndex]
                selectedDotView.backgroundColor = self.indicatorSelectedColor
                selectedDotView.layer.cornerRadius = 8.0
                selectedDotView.snp.updateConstraints { make in
                    make.height.equalTo(16.0)
                    make.width.equalTo(16.0)
                }
                
                let previousDotView: UIView = dots[oldValue]
                previousDotView.backgroundColor = self.indicatorColor
                previousDotView.layer.cornerRadius = 4.0
                previousDotView.snp.updateConstraints { make in
                    make.height.equalTo(8.0)
                    make.width.equalTo(8.0)
                }
            }
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    private var indicatorColor: UIColor = .gray
    private var indicatorSelectedColor: UIColor = .lightGray
    
    func setup(numberOfPages: Int,
               color: UIColor = .lightGray,
               selectedColor: UIColor = .gray) {
        
        //remove previous subviews
        dots.removeAll()
        for eachSubView in self.subviews {
            eachSubView.removeFromSuperview()
        }
        
        self.indicatorColor = color
        self.indicatorSelectedColor = selectedColor
        
        self.backgroundColor = .clear
        
        for _ in 1...numberOfPages {
            let pageDotView = UIView(frame: .zero)
            self.addSubview(pageDotView)
            dots.append(pageDotView)
            
            pageDotView.backgroundColor = self.indicatorColor
            pageDotView.layer.cornerRadius = 4.0
            
            if dots.count > 1 {
                let previousDotView = dots[(dots.count - 2)]

                pageDotView.snp.makeConstraints { make in
                    make.leading.equalTo(previousDotView.snp.trailing).offset(16.0)
                    make.width.equalTo(8.0)
                    make.height.equalTo(8.0)
                    make.centerY.equalToSuperview()
                }
            } else {
                pageDotView.backgroundColor = self.indicatorSelectedColor
                pageDotView.layer.cornerRadius = 8.0
                pageDotView.snp.makeConstraints { make in
                    make.leading.equalTo(0.0)
                    make.width.equalTo(16.0)
                    make.height.equalTo(16.0)
                    make.centerY.equalToSuperview()
                }
            }
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override var intrinsicContentSize: CGSize {
        let dotsWidth = (Double(dots.count - 1) * 8.0) + 16.0
        let spacingWidth = Double(dots.count - 1) * 16.0
        let width = dotsWidth + spacingWidth
        return CGSize(width: width, height: 16.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
