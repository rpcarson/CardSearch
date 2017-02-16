//
//  SavedCardsDataSource.swift
//  CardSearch
//
//  Created by Reed Carson on 2/10/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

private let savedCollectionsCVCellReuse = "savedCollectionsCVCellID"


class SavedCVDataSource: NSObject, UICollectionViewDataSource {
    
    var collection: CardCollection?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let cards = collection?.getCards() else {
            return 0
        }
        
        guard cards.count >= 1 else {
            print("SavedVCDataSource:numberofitems - no cards")
            return 0
        }
        
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: savedCollectionsCVCellReuse, for: indexPath) as! CardCell
        
        let cards = collection?.cards
        
        
        cell.cardData = (cards![indexPath.row])
        
        cell.cardImageView.image = cards?[indexPath.row].image
        
        cell.backgroundColor = UIColor.lightGray
        
        cell.cardNameLabel.text = String(indexPath.row)
       // print(cell.cardData)
        
        return cell

    }
    
}
