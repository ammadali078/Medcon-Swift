//
//  DrugDetailCollectonCell.swift
//  medcon-swift
//
//  Created by Macbook on 30/05/2023.
//

import Foundation
import UIKit
import Imaginary

class DrugDetailCollectonCell: NSObject,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var dataList: [FullInteractionType] = []
    var filteredList : [FullInteractionType] = []
    var openType = "0"
    var name = ""
    var des = ""
    var arrayOfdesc = [String]()
    var arrayOfName = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrugDetailCollectonCell", for: indexPath) as! DrugDetailCollectonViewCell
        
        cell.medDesView.layer.cornerRadius = 8
        cell.medDesView.layer.masksToBounds = true
        cell.medNameView.layer.cornerRadius = 8
        cell.medNameView.layer.masksToBounds = true
        cell.medDesLabel.text = filteredList[indexPath.item].interactionPair?[0].description
        
        var names = ""
        var namesDes = ""
        
        for valueOfNamess in (filteredList[indexPath.item].minConcept ?? [] as [MinConcept]) {
            if names == "" {
                names = names + (valueOfNamess.name ?? "")
            }else {
                names = names + "/" + (valueOfNamess.name ?? "")
            }
            
            if namesDes == "" {
                namesDes = namesDes + (valueOfNamess.name ?? "")
            }else {
                namesDes = namesDes + " + " + (valueOfNamess.name ?? "")
            }
            
        }
        cell.medNameLabel.text = names
        cell.desMedNameLabel.text = namesDes
        
        return cell
        
    }
    
    func setItems (items: [FullInteractionType]?, openType: String) {
        self.dataList = items!
        self.filteredList = items!
    }
    
}

class DrugDetailCollectonViewCell: UICollectionViewCell {
    
    @IBOutlet weak var medDesView: UIView!
    @IBOutlet weak var medNameView: UIView!
    @IBOutlet weak var medNameLabel: UILabel!
    @IBOutlet weak var desMedNameLabel: UILabel!
    @IBOutlet weak var medDesLabel: UILabel!
}



