
//
//  HomeViewController.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 12/02/2022.
//

import UIKit
import JGProgressHUD
import AVKit
import Lightbox
import SnapKit
import FittedSheets
import AVKit
import Alamofire
import ObjectMapper

class HomeViewController: BaseViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    
    let hud = JGProgressHUD()
    
    let vm = HomeViewModel()
    
    var ApiResult : [DataVideos] = []
    
    let baseUrl = "http://medconwebapi-v3.digitrends.pk"
    
    @IBOutlet weak var journalCarouselView: iCarousel!
    @IBOutlet weak var specialityTitle: UILabel!
    @IBOutlet weak var specialityBannerTitle: UILabel!
    @IBOutlet weak var specialityIcon: UIImageView!
    @IBOutlet weak var specialityBanner: UIImageView!
    @IBOutlet weak var specialityTitleBackground: UIView!
    @IBOutlet weak var articlesContainerView: UIView!
    @IBOutlet weak var videosContainerView: UIView!
    @IBOutlet weak var videosCarouselView: iCarousel!
    @IBOutlet weak var galleryContainerView: UIView!
    @IBOutlet weak var galleryListContainerView: UIView!
    @IBOutlet weak var mslCornerContainerView: UIView!
    @IBOutlet weak var mslOneImageView: UIImageView!
    @IBOutlet weak var mslOneTitle: UILabel!
    @IBOutlet weak var mslOnedetail: UILabel!
    @IBOutlet weak var mslTwoContainerView: UIView!
    @IBOutlet weak var mslTwoImageView: UIImageView!
    @IBOutlet weak var mslTwoTitle: UILabel!
    @IBOutlet weak var mslTwodetail: UILabel!
    @IBOutlet weak var mslTwoContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var EmslCollectionView: UICollectionView!
    @IBOutlet weak var eMslMainView: UIView!
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var comingSoonBanner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textLabel1.isHidden = true
        self.textLabel2.isHidden = true
        eMslMainView.layer.cornerRadius = 8
        eMslMainView.layer.masksToBounds = true
        
        self.getPlann()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        eMslMainView.layer.cornerRadius = 8
        eMslMainView.layer.masksToBounds = true
        
        self.textLabel1.isHidden = true
        self.textLabel2.isHidden = true
        
        self.getPlann()
        
        vm.delegate = self
        
        setupUI()
        
        journalCarouselView.reloadData()
        journalCarouselView.bounces = false
        journalCarouselView.isPagingEnabled = true
        journalCarouselView.backgroundColor = .clear
        videosCarouselView.reloadData()
        videosCarouselView.bounces = false
        videosCarouselView.isPagingEnabled = true
        videosCarouselView.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let VideoUrl = ApiResult[indexPath.row].videoUrl ?? ""
        
        if let url = URL(string: baseUrl + VideoUrl) {
            let player = AVPlayer(url:  url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            present(playerViewController, animated: true) {
                player.play()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ApiResult.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmslCollectionCell", for: indexPath) as! EmslCollectionViewCell
        
        let imageUrl = ApiResult[indexPath.row].imageUrl ?? ""
        let VideoUrl = ApiResult[indexPath.row].videoUrl ?? ""
        
        let title = ApiResult[indexPath.row].title
        
        if title == "" {
            
            cell.titleLabelView.text = "VIDEO COMING SOON"
        }else {
            
            cell.titleLabelView.text = ApiResult[indexPath.row].title
        }
        
        let url = URL(string: baseUrl + imageUrl)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.eMSLImageView.image = UIImage(data: data!)
        
        return cell
    }
    
    func getPlann(){
        
        AF.request(Constants.VideoApi, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: nil)
            .responseString(completionHandler: {(response) in
                // On Response
                
                //On Dialog Close
                if (response.error != nil) {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (response.error?.localizedDescription)!)
                    return
                }
                
                let dollsModel = Mapper<DollsModel>().map(JSONString: response.value!) //JSON to model
                
                if dollsModel != nil {
                    
                    if (dollsModel?.success)! {
                        var filter : [DataVideos] = []
                        if let data = dollsModel?.data?.first(where: {$0.categoryName == self.vm.selectedSpeciality.titleString}) {
                            filter = data.videos ?? []
                        }
                        
                        let TypeID = filter.filter{($0.typeId == 4)}
                        
                        if TypeID.count == 0 {
                            
                            self.textLabel1.isHidden = false
                            self.textLabel2.isHidden = false
                            
                            self.textLabel1.text = "VIDEO LIBRARY"
                            self.textLabel2.text = "COMING SOON"
                            
                            self.ApiResult = TypeID
                            
                            self.EmslCollectionView.reloadData()
                            
                        }else {
                            
                            self.textLabel1.isHidden = true
                            self.textLabel2.isHidden = true
                            
                            self.ApiResult = TypeID
                            
                            self.EmslCollectionView.reloadData()
                        }
                        
                        
                        
                    } else {
                        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: (dollsModel?.message!)!)
                    }
                } else {
                    CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "", withMessage: "Failed to connect to server, Please check your internet connection")
                }
                
            })
    }
    
    private func setupUI() {
        
        specialityTitle.text = vm.selectedSpeciality.titleString2
        specialityIcon.image = UIImage(named: vm.selectedSpeciality.iconName)
        specialityBanner.image = UIImage(named: vm.selectedSpeciality.bannerName)
        specialityBannerTitle.text = vm.selectedSpeciality.bannerTitleString
        specialityTitleBackground.backgroundColor = vm.selectedSpeciality.titleBackgroundColor
        
        vm.callJournal()
        vm.callJournalMsl()
        vm.callVideoLibrary()
        vm.callAlbum()
    }
    
    override func optionChanged(option: SpecialityTag) {
        vm.selectedSpeciality = option
        setupUI()
        self.getPlann()
    }
    
    override func openSheet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let controller =  GenericBottomSheetViewController.loadFromNib()
            
            let sheetController = SheetViewController(controller: controller, sizes: [.fixed(300)])
            
            self?.present(sheetController, animated: true, completion: nil)
        }
    }
    
    @IBAction func bottonOptionChangd(_ sender: UIButton) {
        if sender.tag == 101 {
            optionChanged(option: .Pain)
        }
        else if sender.tag == 102 {
            optionChanged(option: .Pediatrics)
        }
        else if sender.tag == 103 {
            optionChanged(option: .CNS)
        }
        else if sender.tag == 104 {
            optionChanged(option: .Respiratory)
        }
        else if sender.tag == 105 {
            optionChanged(option: .WomenMenHealth)
        }
        else if sender.tag == 106 {
            optionChanged(option: .Gastroenterology)
        }
        else if sender.tag == 107 {
            optionChanged(option: .General)
        }
    }
    
    @IBAction func onDrugsClick(_ sender: Any) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DrugManualScreen") as! DrugManualViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    @IBAction func onPAMClick(_ sender: Any) {
        
//        CommonUtils.showMsgDialog(showingPopupOn: self, withTitle: "MedCon", withMessage: "")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PAMScene") as! PAMViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onDolsClick(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DolsViewScene") as! DolsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func viewArticleListView(_ sender: UIButton) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ArtID, withJson: "1")
        let mainViewController: ViewAllArticlesViewController = UIStoryboard(storyboard: .home).instantiateVC()
        mainViewController.mode = .journal
        mainViewController.dataSource = getArticles()
        mainViewController.selectedSpeciality = vm.selectedSpeciality
        
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    @IBAction func viewMslArticleListView(_ sender: UIButton) {
        
        CommonUtils.saveJsonToUserDefaults(forKey: Constants.ArtID, withJson: "2")
        let mainViewController: ViewAllArticlesViewController = UIStoryboard(storyboard: .home).instantiateVC()
        mainViewController.mode = .msl
        mainViewController.dataSource = getArticlesMsl()
        mainViewController.selectedSpeciality = vm.selectedSpeciality
        
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    @IBAction func tappedMslArticle(_ sender: Any) {
        
        if mslOneTitle.text == "Articles Coming Soon" {
            
            return
        }else {
            guard let journal = vm.journalResponseData else { return }
            if let data = journal.data.first(where: {$0.categoryID == vm.selectedSpeciality.GetID}) {
                let filteredData = data.newsJournal.filter({ $0.type == "MSL" })
                let j = filteredData[(sender as AnyObject).tag]
                gotoArticleDetailPage(journal: j)
            }
        }
        
    }
    
    
    @IBAction func viewVideoListView(_ sender: UIButton) {
        let mainViewController: ViewAllArticlesViewController = UIStoryboard(storyboard: .home).instantiateVC()
        mainViewController.mode = .video
        mainViewController.dataSourceVideo = getVideos()
        mainViewController.selectedSpeciality = vm.selectedSpeciality
        
        navigationController?.pushViewController(mainViewController, animated: true)
        
    }
    
    @IBAction func viewGalleryListView(_ sender: UIButton) {
        let mainViewController: ViewAllArticlesViewController = UIStoryboard(storyboard: .home).instantiateVC()
        mainViewController.mode = .gallery
        mainViewController.dataSourceGallery = getGalleryAlbums()
        mainViewController.selectedSpeciality = vm.selectedSpeciality
        
        navigationController?.pushViewController(mainViewController, animated: true)
        
    }
    
    @objc @IBAction func viewAlbumView(_ sender: UIButton) {
        guard let homeVM = getGalleryAlbums() else { return }
        var images: [LightboxImage] = []
        for img in homeVM[sender.tag].getImagesUrl() {
            if let url = URL.init(string: img) {
                images.append(LightboxImage(imageURL: url))
            }
        }
        
        let controller = LightboxController(images: images)
        
        controller.dynamicBackground = true
        
        present(controller, animated: true, completion: nil)
        
    }
    
    func getArticles() -> JournalResponse? {
        guard let journal = vm.journalResponseData else { return nil }
        return journal
    }
    
    func getArticlesMsl() -> JournalResponse? {
        guard let journal = vm.journalMslResponseData else { return nil }
        return journal
    }
    
    func getVideos() -> VideoLibraryResponse? {
        guard let videos = vm.videoLibraryResponseData else { return nil }
        return videos
    }
    
    func getGalleryAlbums() -> [GalleryTableViewCellDataSource]? {
        guard let journal = vm.albumResponseData else { return nil }
        return journal.data
    }
    
    private func playHomeVideo(video: Video) {
        if let url = URL.init(string: video.videoFullUrl) {
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.showsPlaybackControls = true
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    
    private func gotoArticleDetailPage(journal: NewsJournal) {
        let articleDetailViewController: AticleDetailViewController = UIStoryboard(storyboard: .home).instantiateVC()
        //        let ali = journal
        articleDetailViewController.dataSource = journal
        articleDetailViewController.selectedSpeciality = vm.selectedSpeciality
        navigationController?.pushViewController(articleDetailViewController, animated: true)
        
    }
    
    @objc func buttonVideoTapped(sender : UIButton) {
        guard let video = vm.videoLibraryResponseData else { return }
        if let data = video.data.first(where: {$0.categoryID == vm.selectedSpeciality.GetID}) {
            let video = data.videos[sender.tag]
            playHomeVideo(video: video)
        }
    }
    
    @objc func buttonArticleTapped(sender : UIButton) {
        guard let journal = vm.journalResponseData else { return }
        if let data = journal.data.first(where: {$0.categoryID == vm.selectedSpeciality.GetID}) {
            let filteredData = data.newsJournal.filter({ $0.type != "MSL" })
            let j = filteredData[sender.tag]
            gotoArticleDetailPage(journal: j)
        }
    }
}

extension HomeViewController: iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        if carousel == journalCarouselView {
            guard let journal = vm.journalResponseData else { return 0 }
            var data = journal.data.first(where: {$0.categoryID == vm.selectedSpeciality.GetID})
            
            let filteredData = data?.newsJournal.filter({ $0.type != "MSL" })
            
            if filteredData?.count ?? 0 > 3{
                return 3
            }else{
                return filteredData?.count ?? 0
            }
            
            // ammad
            //http://medconwebapi-v3.digitrends.pk/api/NewAndJournals/Index?Type=All
            
        }
        else if carousel == videosCarouselView {
            guard let journal = vm.videoLibraryResponseData else { return 0 }
            var data = journal.data.first(where: {$0.categoryID == vm.selectedSpeciality.GetID})
            let filterVideo = data?.videos.filter({ $0.typeID != 4 })
            
            if filterVideo?.count ?? 0 > 3 {
                return 3
            }else {
                return filterVideo?.count ?? 0
            }
        }
        return 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let screenSize: CGRect = UIScreen.main.bounds
        if carousel == journalCarouselView {
            guard let journal = vm.journalResponseData else { return UIView() }
            if let data = journal.data.first(where: {$0.categoryID == vm.selectedSpeciality.GetID}) {
                let filteredData = data.newsJournal.filter({ $0.type != "MSL" })
                let vu = UIView.init(frame: CGRect(x: 16, y: 0, width: screenSize.width - (filteredData.count > 1 ? 64 :32), height: 160))
                let journalView = getJournalArticleView(journal: filteredData[index], index: index)
                vu.addSubview(journalView)
                
                journalView.snp.makeConstraints { make in
                    make.left.right.top.bottom.equalToSuperview()
                }
                return vu
            }
        }
        else if carousel == videosCarouselView {
            guard let video = vm.videoLibraryResponseData else { return UIView() }
            if let data = video.data.first(where: {$0.categoryID == vm.selectedSpeciality.GetID}) {
                let filteredVideo = data.videos.filter({ $0.typeID != 4})
                let vu = UIView.init(frame: CGRect(x: 8, y: 0, width: screenSize.width - (filteredVideo.count > 1 ? 64 :32), height: 160))
                let videoView = getVideoView(video: filteredVideo[index], index: index)
                vu.addSubview(videoView)
                
                videoView.snp.makeConstraints { make in
                    make.left.right.top.bottom.equalToSuperview()
                }
                return vu
            }
        }
        return UIView()
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.05
        }
        return value
    }
}

extension HomeViewController: HomeWebServiceDelegate {
    func successJournals() {
        journalCarouselView.reloadData()
    }
    
    func failureJournals() {
        
    }
    
    func successJournalsMsl() {
        guard let journal = vm.journalMslResponseData else { return }
        if let data = journal.data.first(where: {$0.categoryID == vm.selectedSpeciality.GetID}) {
            comingSoonBanner.isHidden = true
            if let url = URL.init(string: data.newsJournal.first?.imageFullUrl ?? "") {
                
                mslOneImageView.af.setImage(withURL: url)
                
                mslOneTitle.text = data.newsJournal.first?.title
                mslOnedetail.text = data.newsJournal.first?.newsJournalDescription
                
                mslCornerContainerView.isHidden = false
            }
            else {
                mslTwoContainerHeight.constant = 100
                comingSoonBanner.isHidden = false
                //                mslOneImageView.image = UIImage(named: "Article-banner");
                comingSoonBanner.image = UIImage(named: "Article-banner");
                //                mslOneTitle.text = "Articles Coming Soon"
                mslOnedetail.text = ""
                
                //                mslCornerContainerView.isHidden = true
            }
            if data.newsJournal.count > 1, let url = URL.init(string: data.newsJournal[1].imageFullUrl) {
                mslTwoContainerView.isHidden = false
                mslTwoContainerHeight.constant = 100
                mslTwoImageView.af.setImage(withURL: url)
                mslTwoTitle.text = data.newsJournal[1].newsJournalDescription
                mslTwodetail.text = data.newsJournal[1].title
            } else{
                mslTwoContainerView.isHidden = true
                mslTwoContainerHeight.constant = 100
            }
        }
    }
    
    func failureJournalsMsl() {
        mslCornerContainerView.isHidden = true
    }
    
    func successVideoLibrary() {
        videosCarouselView.reloadData()
    }
    
    func failureVideoLibrary() {
        
    }
    
    func successAlbum() {
        guard let albums = vm.albumResponseData else { return }
        createAlbumViews(albums: albums)
    }
    
    func failureAlbum() {
        
    }
    
}

extension HomeViewController {
    private func getJournalArticleView(journal: NewsJournal, index: Int) -> UIView {
        let vu = UIView()
        
        vu.layer.cornerRadius = 8.0
        vu.clipsToBounds = true
        
        let image = UIImageView()
        
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        if let url = URL.init(string: journal.imageFullUrl ) {
            image.af.setImage(withURL: url)
        }
        vu.addSubview(image)
        image.snp.makeConstraints({ make in
            make.left.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            //            make.top.equalToSuperview().offset(30)
            make.width.equalTo(150)
            //            make.height.equalTo(100)
        })
        
        let ArticaleView = UIView()
        //        ArticaleView.numberOfLines = 0
        ArticaleView.backgroundColor = vm.selectedSpeciality.titleBackgroundColor.withAlphaComponent(0.3)
        ArticaleView.layer.cornerRadius = 12
        //        ArticaleView.font = AppDefaultTheme.shared.getFont(withName: .ItemDescriptionFont)
        vu.addSubview(ArticaleView)
        ArticaleView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-3)
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(50)
            make.height.equalTo(23)
            
        }
        
        let ArticaleLabel = UILabel()
        ArticaleLabel.numberOfLines = 0
        ArticaleLabel.text = "Article"
        ArticaleLabel.textColor = vm.selectedSpeciality.titleBackgroundColor
        ArticaleLabel.font = AppDefaultTheme.shared.getFont(withName: .ItemDescriptionFont)
        vu.addSubview(ArticaleLabel)
        ArticaleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(9.5)
            
        }
        
        let headingLabel = UILabel()
        headingLabel.numberOfLines = 2
        headingLabel.text = journal.title
        headingLabel.font = AppDefaultTheme.shared.getFont(withName: .ItemTitleFont)
        vu.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(10)
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-16)
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = journal.newsJournalDescription
        descriptionLabel.font = AppDefaultTheme.shared.getFont(withName: .ItemDescriptionFont)
        vu.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(8)
            make.top.equalTo(headingLabel.snp.bottom).offset(4)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        vu.backgroundColor = .white
        let actionButton = UIButton()
        actionButton.tag = index
        actionButton.addTarget(self, action: #selector(buttonArticleTapped), for: .touchUpInside)
        vu.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        return vu
    }
    
    private func createAlbumViews(albums: AlbumResponse) {
        galleryListContainerView.subviews.forEach({$0.removeFromSuperview()})
        var previousVU: UIView?
        var index = 0
        for album in albums.data {
            let vu = UIView()
            galleryListContainerView.addSubview(vu)
            vu.snp.makeConstraints { make in
                if previousVU == nil {
                    make.top.equalToSuperview()
                }
                else {
                    make.top.equalTo(previousVU!.snp.bottom)
                }
                make.left.right.equalToSuperview()
                make.height.equalTo(50)
            }
            previousVU = vu
            
            let galleryIcon = UIImageView()
            galleryIcon.contentMode = .scaleAspectFill
            if let url = URL.init(string: album.getImageUrl()) {
                galleryIcon.af.setImage(withURL: url)
            }
            galleryIcon.layer.cornerRadius = 20
            galleryIcon.layer.masksToBounds = true
            vu.addSubview(galleryIcon)
            galleryIcon.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.height.width.equalTo(40)
                make.centerY.equalToSuperview()
            }
            
            let albumTitle = UILabel()
            albumTitle.text = album.albumName
            vu.addSubview(albumTitle)
            albumTitle.snp.makeConstraints { make in
                make.left.equalTo(galleryIcon.snp.right).offset(20)
                make.centerY.equalToSuperview()
            }
            
            let albumButton = UIButton()
            albumButton.setTitle(">", for: .normal)
            albumButton.backgroundColor = AppDefaultTheme.shared.getColor(withName: .ButtonBlueColor)
            albumButton.titleLabel?.textColor = .white
            albumButton.addTarget(self, action: #selector(viewAlbumView), for: .touchUpInside)
            albumButton.cornerRadiusValue = 20
            albumButton.tag = index
            vu.addSubview(albumButton)
            albumButton.snp.makeConstraints { make in
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.height.equalTo(40)
            }
            index += 1
        }
    }
    
    private func getVideoView(video: Video, index: Int) -> UIView {
        let vu = UIView()
        
        vu.layer.cornerRadius = 5
        vu.clipsToBounds = true
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        if let url = URL.init(string: video.imageFullUrl ) {
            image.af.setImage(withURL: url)
        }
        
        vu.addSubview(image)
        image.snp.makeConstraints({ make in
            make.left.top.equalToSuperview()
            make.bottom.right.equalToSuperview()
        })
        
        let headingLabel = UILabel()
        headingLabel.numberOfLines = 1
        headingLabel.text = video.title
        headingLabel.font = AppDefaultTheme.shared.getFont(withName: .ItemTitleFont2)
        headingLabel.backgroundColor = .white
        vu.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        vu.backgroundColor = .white
        let actionButton = UIButton()
        actionButton.tag = index
        actionButton.addTarget(self, action: #selector(buttonVideoTapped), for: .touchUpInside)
        vu.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        return vu
    }
}
