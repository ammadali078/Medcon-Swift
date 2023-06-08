//
//  PopularCollectionCell.swift
//  medcon-swift
//
//  Created by Macbook on 18/04/2023.
//

import Foundation
import UIKit
import SDWebImage

class PopularCollectionCell: NSObject,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var dataList: [MostPopularResult] = []
    var filteredList : [MostPopularResult] = []
    var openType = "0"
    var onStartClick: ((MostPopularResult) -> Void)? = nil
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionCell", for: indexPath) as! PopularCollectionViewCell
        
        let index = indexPath.row
        let Json = filteredList[index]
        cell.MostPopularResult = Json
        cell.onStartClick = onStartClick
        
        cell.backViewOutlet.layer.cornerRadius = 8
        cell.backViewOutlet.layer.masksToBounds = true
        cell.popularImageView.layer.cornerRadius = 8
        cell.popularImageView.layer.masksToBounds = true
        
        DispatchQueue.main.async {
            
            let baseUrl = "http://medcon-beta.digitrends.pk"

            let imageUrl = self.filteredList[indexPath.row].imageURL ?? ""

            let urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            cell.popularImageView.sd_setImage(with: URL(string: "\(baseUrl)\(urlString)"), completed: nil)
        }
        
       
        
        
        cell.popularLabelView.text = filteredList[indexPath.item].title
        
        return cell
        
    }
    
    func setItems (items: [MostPopularResult]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
        
    }
}

class PopularCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var popularImageView: UIImageView!
    @IBOutlet weak var popularLabelView: UILabel!
    @IBOutlet weak var backViewOutlet: UIView!
    var MostPopularResult: MostPopularResult? = nil
    var onStartClick: ((MostPopularResult) -> Void)? = nil
    
    @IBAction func onClickBtn(_ sender: Any) {
        onStartClick!(MostPopularResult!)
    }
    
}



