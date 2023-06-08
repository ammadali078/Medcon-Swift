//
//  MEDListCollectionCell.swift
//  medcon-swift
//
//  Created by Macbook on 29/05/2023.
//

import Foundation
import UIKit

class MEDListCollectionCell: NSObject,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var dataList: [Candidate] = []
    var filteredList : [Candidate] = []
    var openType = "0"
    var onStartClick: ((Candidate) -> Void)? = nil
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MEDListCollectionCell", for: indexPath) as! MEDListCollectionViewCell
        
        let index = indexPath.row
        let Json = filteredList[index]
        cell.Candidate = Json
        cell.onStartClick = onStartClick
       
        cell.medName.text = filteredList[indexPath.item].name
        
        return cell
        
    }
    
    func setItems (items: [Candidate]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
        
    }
}

class MEDListCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var medName: UILabel!
    var Candidate: Candidate? = nil
    var onStartClick: ((Candidate) -> Void)? = nil
    
    @IBAction func onBtnClicked(_ sender: Any) {
        onStartClick!(Candidate!)
    }
    
}



