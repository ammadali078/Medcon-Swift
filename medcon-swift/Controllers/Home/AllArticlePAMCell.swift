//
//  AllArticlePAMCell.swift
//  medcon-swift
//
//  Created by Macbook on 26/04/2023.
//

import Foundation
import UIKit

class AllArticlePAMCell: NSObject,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var dataList: [PatientAwareness] = []
    var filteredList : [PatientAwareness] = []
    var onStartClick: ((PatientAwareness) -> Void)? = nil
    
    var openType = "0"
    let baseUrl = "http://medcon-beta.digitrends.pk"
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllArticlePAMCell", for: indexPath) as! AllArticlePAMViewCell
        
        let index = indexPath.row
        let Json = filteredList[index]
        cell.PatientAwareness = Json
        cell.onStartClick = onStartClick
        
        cell.backView.layer.cornerRadius = 8
        cell.backView.layer.masksToBounds = true
        cell.articleImageView.layer.cornerRadius = 8
        cell.articleImageView.layer.masksToBounds = true
          
        DispatchQueue.main.async {
            
            let imageUrl = self.filteredList[indexPath.row].imageUrl ?? ""

            let urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            cell.articleImageView.sd_setImage(with: URL(string: "\(self.baseUrl)\(urlString)"), completed: nil)
                
        }
     
        cell.articleHeadingLabel.text = filteredList[indexPath.item].title
        
        cell.articleTextLabel.attributedText = filteredList[indexPath.item].detailsHtml?.htmlToAttributedString
        
        return cell
        
    }
    
    func setItems (items: [PatientAwareness]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
        
    }
    
}


class AllArticlePAMViewCell: UICollectionViewCell {
  
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleHeadingLabel: UILabel!
    @IBOutlet weak var articleTextLabel: UILabel!
    var PatientAwareness: PatientAwareness? = nil
    var onStartClick: ((PatientAwareness) -> Void)? = nil
    
    @IBOutlet weak var backView: UIView!
    
    @IBAction func onArticleClick(_ sender: Any) {
        onStartClick!(PatientAwareness!)
    }
    
}

extension String {
    var htmlToAttributedStringAll : NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToStringObjectAll : String {
        return htmlToAttributedStringAll?.string ?? ""
    }
}


