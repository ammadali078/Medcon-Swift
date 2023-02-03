//
//  ArticleTableViewCell.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 25/02/2022.
//

import Foundation
import UIKit

protocol ArticleTableViewCellDataSource {
    func getImageUrl() -> String
    func getTitleText() -> String
    func getDescriptionText() -> String
    func getHtmlText() -> String
    func getReferenceDetails() -> String
    func getTypeText() -> String
    
}
protocol VideoTableViewCellDataSource {
    func getImageUrl() -> String
    func getVideoUrl() -> String
    func getTitleText() -> String
}
protocol GalleryTableViewCellDataSource {
    func getImageUrl() -> String
    func getTitleText() -> String
    func getImagesUrl() -> [String]
}

class ArticleTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ArticleTableViewCell"
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleViewOutlet: UIView!
    @IBOutlet weak var articleLabelOutlet: UILabel!
    
    
    var dataSource: ArticleTableViewCellDataSource?
    var selectedSpeciality: SpecialityTag = .Gastroenterology
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        articleImageView.layer.cornerRadius = 8
        articleImageView.layer.masksToBounds = true
        articleViewOutlet.layer.cornerRadius = 12
        articleViewOutlet.layer.masksToBounds = true
        articleViewOutlet.backgroundColor = selectedSpeciality.titleBackgroundColor.withAlphaComponent(0.3)
        articleLabelOutlet.textColor = selectedSpeciality.titleBackgroundColor
        articleLabelOutlet.text = "Article"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
    }
    
    func configCell() {
        guard let ds = dataSource else { return }
        
        articleTitleLabel.text = ds.getTitleText()
        articleDescriptionLabel.text = ds.getDescriptionText()
        
        
        
        if let url = URL.init(string: ds.getImageUrl()) {
            articleImageView.af.setImage(withURL: url)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
}

class VideoTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "VideoTableViewCell"
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    var dataSource: VideoTableViewCellDataSource?
    var dataSourceAlbum: GalleryTableViewCellDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        videoImageView.image = nil
    }
    
    func configCell() {
        guard let ds = dataSource else {
            configAlbumCell()
            return
        }
        videoTitleLabel.text = ds.getTitleText()
        
        if let url = URL.init(string: ds.getImageUrl()) {
            videoImageView.af.setImage(withURL: url)
        }
    }
    
    func configAlbumCell() {
        guard let ds = dataSourceAlbum else {
            return
        }
        videoTitleLabel.text = ds.getTitleText()
        
        if let url = URL.init(string: ds.getImageUrl()) {
            videoImageView.af.setImage(withURL: url)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
}
