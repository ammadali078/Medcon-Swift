//
//  PAMCollectionCell.swift
//  medcon-swift
//
//  Created by Macbook on 14/04/2023.
//


import Foundation
import UIKit
import SDWebImage

class PAMCollectionCell: NSObject,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var dataList: [PatientAwareness] = []
    var filteredList : [PatientAwareness] = []
    var onStartClick: ((PatientAwareness) -> Void)? = nil
    
    var openType = "0"
//    let baseUrl = "http://medcon-beta.digitrends.pk"
    let baseUrl = "http://medconwebapi-v3.digitrends.pk"
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count > 3 ? 3 : filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PAMCollectionCell", for: indexPath) as! PAMCollectionViewCell
        
            let index = indexPath.row
            let Json = filteredList[index]
            cell.PatientAwareness = Json
            cell.onStartClick = onStartClick
          
            cell.backViewOutlet.layer.cornerRadius = 8
            cell.backViewOutlet.layer.masksToBounds = true
            cell.articleImageView.layer.cornerRadius = 8
            cell.articleImageView.layer.masksToBounds = true
        
        DispatchQueue.main.async {
            
            let imageUrl = self.filteredList[indexPath.row].imageUrl ?? ""

            let urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            cell.articleImageView.sd_setImage(with: URL(string: "\(self.baseUrl)\(urlString)"), completed: nil)
                
        }
        
        cell.articleLabelView.text = filteredList[indexPath.item].title
        
        cell.articleLabelView2.attributedText = filteredList[indexPath.item].detailsHtml?.htmlToAttributedStringHTml
        
        return cell
        
    }
    
    func setItems (items: [PatientAwareness]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
        
    }
    
}


class PAMCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleLabelView: UILabel!
    @IBOutlet weak var articleLabelView2: UILabel!
    
    @IBOutlet weak var backViewOutlet: UIView!
    var PatientAwareness: PatientAwareness? = nil
    var onStartClick: ((PatientAwareness) -> Void)? = nil
    
    @IBAction func onClickCell(_ sender: Any) {
        onStartClick!(PatientAwareness!)
    }
    
}

extension String {
    var htmlToAttributedStringHTml : NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToStringObject : String {
        return htmlToAttributedStringHTml?.string ?? ""
    }
}


