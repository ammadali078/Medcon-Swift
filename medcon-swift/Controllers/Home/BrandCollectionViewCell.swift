//
//  BrandCollectionViewCell.swift
//  medcon-swift
//
//  Created by Macbook on 24/08/2023.
//

import Foundation
import UIKit


class BrandCollectionViewCell: NSObject,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var dataList: [PatientAwareness] = []
    var filteredList : [PatientAwareness] = []
    var onStartClick: ((PatientAwareness) -> Void)? = nil
    
    var openType = "0"
//    let baseUrl = "http://medcon-beta.digitrends.pk"
    let baseUrl = "http://medconwebapi-v3.digitrends.pk"
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCollectionViewCell", for: indexPath) as! BrandCollectionView
        
       
        return cell
        
    }
    
    func setItems (items: [PatientAwareness]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
        
    }
    
}


class BrandCollectionView: UICollectionViewCell {
  
    
    var PatientAwareness: PatientAwareness? = nil
    var onStartClick: ((PatientAwareness) -> Void)? = nil
    
    
}




