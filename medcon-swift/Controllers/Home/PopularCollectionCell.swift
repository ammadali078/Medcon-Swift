//
//  PopularCollectionCell.swift
//  medcon-swift
//
//  Created by Macbook on 18/04/2023.
//

import Foundation
import UIKit

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
        
        cell.backViewOutlet.layer.cornerRadius = 8
        cell.backViewOutlet.layer.masksToBounds = true
        cell.popularImageView.layer.cornerRadius = 8
        cell.popularImageView.layer.masksToBounds = true
        
        
        let baseUrl = "http://medcon-beta.digitrends.pk"
        
        let imageUrl = filteredList[indexPath.row].imageURL ?? ""
        
        var urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""


        let url = URL(string: baseUrl + urlString)

        let data = try? Data(contentsOf: url!)
        
        cell.popularImageView.image = UIImage(data: data!)
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



