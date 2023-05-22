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
    var onCellClick: ((PatientAwareness) -> Void)? = nil
    
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
        cell.onCellClick = onCellClick
        
        cell.backView.layer.cornerRadius = 8
        cell.backView.layer.masksToBounds = true
        cell.articleImageView.layer.cornerRadius = 8
        cell.articleImageView.layer.masksToBounds = true
          
            let imageUrl = filteredList[indexPath.row].imageUrl ?? ""
        
        var urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""


            let url = URL(string: baseUrl + urlString)
       
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch

            cell.articleImageView.image = UIImage(data: data!)
     
        cell.articleHeadingLabel.text = filteredList[indexPath.item].title
        
        cell.articleTextLabel.attributedText = filteredList[indexPath.item].html?.htmlToAttributedString
        
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
    
    @IBOutlet weak var backView: UIView!
    var PatientAwareness: PatientAwareness? = nil
    var onCellClick: ((PatientAwareness) -> Void)? = nil
    
    @IBAction func onArticleClick(_ sender: Any) {
        onCellClick!(PatientAwareness!)
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


