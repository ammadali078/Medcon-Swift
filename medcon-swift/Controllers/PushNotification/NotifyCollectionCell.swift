//
//  NotifyCollectionCell.swift
//  medcon-swift
//
//  Created by Macbook on 16/08/2023.
//

import Foundation
import UIKit
import SDWebImage

class NotifyCollectionCell: NSObject,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var dataList: [NotifyData] = []
    var filteredList : [NotifyData] = []
    var onStartClick: ((NotifyData) -> Void)? = nil
    
    var openType = "0"
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotifyCollectionCell", for: indexPath) as! NotifyCollectionViewCell
        
            let index = indexPath.row
            let Json = filteredList[index]
        
        cell.notifyTitleLabel.text = filteredList[indexPath.item].title
        cell.notifyDescLabel.text = filteredList[indexPath.item].description
         
        return cell
        
    }
    
    func setItems (items: [NotifyData]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
        
    }
    
}


class NotifyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var notifyTitleLabel: UILabel!
    @IBOutlet weak var notifyDescLabel: UILabel!
    
}



