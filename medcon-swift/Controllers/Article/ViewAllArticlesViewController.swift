//
//  ViewAllArticlesViewController.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 23/02/2022.
//

import UIKit
import AVKit
import Lightbox
import FittedSheets

class ViewAllArticlesViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var specialityTitle: UILabel!
    @IBOutlet weak var specialityBannerTitle: UILabel!
    @IBOutlet weak var specialityIcon: UIImageView!
    @IBOutlet weak var specialityBanner: UIImageView!
    @IBOutlet weak var specialityTitleBackground: UIView!
    
    var dataSource: JournalResponse?
    var dataSourceVideo: VideoLibraryResponse?
    var dataSourceGallery: [GalleryTableViewCellDataSource]?
    var selectedSpeciality: SpecialityTag = .Gastroenterology
    var mode = ListItemMode.journal
    var selectedDataSource = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == .journal {
            setTitle(withText: "ARTICLES")
        }
        else if mode == .video {
            setTitle(withText: "VIDEOS")
        }
        else if mode == .gallery {
            setTitle(withText: "Gallery")
        }
        else {
            setTitle(withText: "E-MSL")
        }
        setupUI()
    }
    
    private func setupUI() {
        specialityTitle.text = selectedSpeciality.titleString2
        specialityIcon.image = UIImage(named: selectedSpeciality.iconName)
        specialityBanner.image = UIImage(named: selectedSpeciality.bannerName)
        specialityBannerTitle.text = selectedSpeciality.bannerTitleString
        specialityTitleBackground.backgroundColor = selectedSpeciality.titleBackgroundColor
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleDetail" {
            let articleDetail = segue.destination as! AticleDetailViewController
            articleDetail.dataSource = getArticles()?[selectedDataSource]
            articleDetail.selectedSpeciality = selectedSpeciality
        }
    }
    
    private func getArticles() -> [ArticleTableViewCellDataSource]? {
        guard let journal = dataSource else { return nil }
        
       let ArtID = CommonUtils.getJsonFromUserDefaults(forKey: Constants.ArtID)
        
        if ArtID == "1" {
            
            if let data = journal.data.first(where: {$0.categoryID == selectedSpeciality.GetID}) {
                let filteredData = data.newsJournal.filter({ $0.type != "MSL" })
                return filteredData
            }
            
        }else {
            if let data = journal.data.first(where: {$0.categoryID == selectedSpeciality.GetID}) {
                let filteredData = data.newsJournal.filter({ $0.type == "MSL" })
                return filteredData
            }
            
        }
    
        return nil
    }
    
    
    func getVideos() -> [VideoTableViewCellDataSource]? {
        guard let videos = dataSourceVideo else { return nil }
        if let data = videos.data.first(where: {$0.categoryID == selectedSpeciality.GetID}) {
            let filterVideos = data.videos.filter({ $0.typeID != 4})
            
            return filterVideos
        }
        return nil
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
    
    override func optionChanged(option: SpecialityTag) {
        selectedSpeciality = option
        setupUI()
    }
    
    override func openSheet() {
        let controller =  GenericBottomSheetViewController.loadFromNib()

        let sheetController = SheetViewController(controller: controller)

        self.navigationController?.present(sheetController, animated: true, completion: nil)
    }
}

extension ViewAllArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if mode == .journal || mode == .msl {
            guard let homeVM = getArticles() else { return 0 }
            return homeVM.count
        }
        else if mode == .video {
            guard let homeVM = getVideos() else { return 0 }
            return homeVM.count
        }
        else {
            guard let homeVM = dataSourceGallery else { return 0 }
            return homeVM.count
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mode == .journal || mode == .msl {
            if let scell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.cellIdentifier, for: indexPath) as? ArticleTableViewCell {
                
                guard let homeVM = getArticles() else { return UITableViewCell() }
                scell.dataSource = homeVM[indexPath.row]
                scell.configCell()
                return scell
            }
            else {
                return UITableViewCell()
            }
        }
        else if mode == .video {
            if let scell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.cellIdentifier, for: indexPath) as? VideoTableViewCell {
                guard let homeVM = getVideos() else { return UITableViewCell() }
                scell.dataSource = homeVM[indexPath.row]
                scell.configCell()
                return scell
            }
            else {
                return UITableViewCell()
            }
        }
        else {
            if let scell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.cellIdentifier, for: indexPath) as? VideoTableViewCell {
                guard let homeVM = dataSourceGallery else { return UITableViewCell() }
                scell.dataSourceAlbum = homeVM[indexPath.row]
                scell.configCell()
                return scell
            }
            else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedDataSource = indexPath.row
        if mode == .journal || mode == .msl {
            performSegue(withIdentifier: "articleDetail", sender: nil)
        }
        else if mode == .video {
            if let vdo = getVideos()?[selectedDataSource] {
                if let url = URL.init(string: vdo.getVideoUrl()) {
                    let player = AVPlayer(url: url)
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    playerViewController.showsPlaybackControls = true
                    self.present(playerViewController, animated: true) {
                        playerViewController.player!.play()
                    }
                }
            }
        }
        else {
            openAlbumImages()
        }
    }
    
    // not using as feel un nessecary step added in pod flow
    private func openVideo() {
        if let vdo = getVideos()?[selectedDataSource] {
            if let url = URL.init(string: vdo.getVideoUrl()), let imgUrl = URL.init(string: vdo.getImageUrl()) {
                let images: [LightboxImage] = [LightboxImage(imageURL: imgUrl, text: vdo.getTitleText(), videoURL: url)]
                let controller = LightboxController(images: images)
                controller.dynamicBackground = true

                present(controller, animated: true, completion: nil)
            }
        }
    }
    
    private func openAlbumImages() {
        guard let homeVM = dataSourceGallery else { return }
        var images: [LightboxImage] = []
        for img in homeVM[selectedDataSource].getImagesUrl() {
            if let url = URL.init(string: img) {
                images.append(LightboxImage(imageURL: url))
            }
        }
        
        let controller = LightboxController(images: images)

        controller.dynamicBackground = true

        present(controller, animated: true, completion: nil)
    }
}
