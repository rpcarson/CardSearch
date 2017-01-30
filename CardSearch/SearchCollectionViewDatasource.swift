//
//  SearchCollectionViewDatasource.swift
//  CardSearch
//
//  Created by Reed Carson on 1/30/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


class SearchCollectionViewDatasource: NSObject, UICollectionViewDataSource {
    
    var cardManager: CardManager = CardManager()
    
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardManager.cards.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCell
        
        let card = cardManager.cards[indexPath.row]
        
        cell.cardData = card
        
        if useDummyData {
            cell.cardNameLabel.text = String(describing: indexPath.row)
            cell.backgroundColor = UIColor.gray
            return cell
        }
        
        if !useImages {
            cell.cardNameLabel.text = "# \(indexPath.row), \(card.name)"
            cell.backgroundColor = UIColor.gray
            //cell.cardImageView.image = cell.cardData.image
            return cell
        }
        
        cell.cardNameLabel.isHidden = true
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let card = cardManager.cards[indexPath.row]
        
        guard let image = JSONParser.parser.getImageNoQueue(imageURL: card.imageURL) else {
            print("CCVC:willDisplayCell  - no card image retrieved")
            // TODO - display question mark
            return
        }
        
        (cell as! CardCell).setImage(image: image, andDisplay: true)
        
        print("CCVC willDisplayCell  card.image set")
        
        
    }
    
    
    
}
