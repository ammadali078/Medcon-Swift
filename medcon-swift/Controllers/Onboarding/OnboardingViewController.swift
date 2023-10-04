//
//  OnboardingViewController.swift
//  staerter-kit
//
//  Created by Muhammad Yawar Sohail on 22/06/2021.
//

import UIKit

import FirebaseDatabase
import FirebaseAuth

class OnboardingViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewIndicator: UIStackView!
    private var indicatorView: PageIndicatorView!
    private var stackViewPages: UIStackView!
    var ref: DatabaseReference!
    
    var pages: [OboardingCarouselModel] = [OboardingCarouselModel]()
    private var currentPageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
       

        ref.child("version/ios/-NccAkdfQBlTQfxUCZrL").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let score = value?["version"] as? String ?? ""
                let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            
                if score == appVersion {
                   
                    print("ali")
                }else {
                    
                    CommonUtils.showMsgDialogWithupdate(showingPopupOn: self, withTitle: "Medcon", withMessage: "There is an Update available! Please update to use this App", onOkClicked: {() in
                        if let url = URL(string: "itms-apps://itunes.apple.com/app/medcon-2019/id1387008793") {
                            UIApplication.shared.open(url)
//                            self.token = "0"
//                            CommonUtils.saveJsonToUserDefaults(forKey: Constants.ammad, withJson: self.token)
                        }
                    })
                    
                    
                }
            
                // ...
            }) { (error) in
                    print(error.localizedDescription)
        }
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
            scrollView.contentSize = .init(width: stackViewPages.frame.width, height: scrollView.frame.height)
        
    }
    
    private func setupUI() {
        setupButtons()
        setIndicatorView()
        setupPages()
    }
    
    private func setupButtons() {
    }
    
    private func setIndicatorView() {
        indicatorView = PageIndicatorView(frame: .zero)
        indicatorView.setup(numberOfPages: self.pages.count)
        stackViewIndicator.addArrangedSubview(indicatorView)
        stackViewIndicator.sizeToFit()
    }
    
    private func setupPages() {
        scrollView.isPagingEnabled = true
        stackViewPages = UIStackView.init(frame: .zero)
        stackViewPages.axis = .horizontal
        stackViewPages.alignment = .fill
        stackViewPages.distribution = .fillProportionally
        //add to scrollview
        scrollView.addSubview(stackViewPages)
        //constrainnt
        stackViewPages.snp.makeConstraints { (make) in
            make.leading.equalTo(scrollView.snp.leading)
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        //pages
        for i in 0 ..< self.pages.count {
            guard let pageView: OnboardingPageView = OnboardingPageView.instantiateFromNib() else { return }
            pageView.set(page: self.pages[i])
            //add in stack
            stackViewPages.addArrangedSubview(pageView)
            //constraint
            pageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.width.equalTo(scrollView.snp.width)
                make.height.equalToSuperview()
            }
            
            pageView.layoutIfNeeded()
        }
        
        stackViewPages.sizeToFit()
        stackViewPages.layoutIfNeeded()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
    }
    
    @objc private func buttonActions(button: UIButton) {
        //        if button == buttonPrimary {
        //        }
        //        else if button == buttonPrimary, currentPageIndex < (pages.count - 1) {
        //        }
    }
    
    private func moveToNext() {
        let nextPage = currentPageIndex + 1
        let offset = nextPage * Int(scrollView.bounds.width)
        indicatorView.selectedIndex = nextPage
        currentPageIndex = nextPage
        scrollView.setContentOffset(.init(x: CGFloat(offset), y: 0.0), animated: true)
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        indicatorView?.selectedIndex = pageIndex
        currentPageIndex = pageIndex
    }
    
}
