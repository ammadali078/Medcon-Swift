//
//  PAMCollectionCell.swift
//  medcon-swift
//
//  Created by Macbook on 14/04/2023.
//


import Foundation
import UIKit

class PAMCollectionCell: NSObject,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var dataList: [PatientAwareness] = []
    var filteredList : [PatientAwareness] = []
    
    var openType = "0"
    let baseUrl = "http://medcon-beta.digitrends.pk"
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count > 3 ? 3 : filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PAMCollectionCell", for: indexPath) as! PAMCollectionViewCell
          
            cell.backViewOutlet.layer.cornerRadius = 8
            cell.backViewOutlet.layer.masksToBounds = true
            cell.articleImageView.layer.cornerRadius = 8
            cell.articleImageView.layer.masksToBounds = true
        
            let imageUrl = filteredList[indexPath.row].imageUrl ?? ""

            let url = URL(string: baseUrl + imageUrl)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            cell.articleImageView.image = UIImage(data: data!)
     
       
        cell.articleLabelView.text = filteredList[indexPath.item].title
        
        cell.articleLabelView2.attributedText = filteredList[indexPath.item].html?.htmlToAttributedString
        
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
    
    @IBAction func onClickCell(_ sender: Any) {
        
        
        
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


