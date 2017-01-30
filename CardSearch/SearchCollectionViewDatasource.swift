//
//  SearchCollectionViewDatasource.swift
//  CardSearch
//
//  Created by Reed Carson on 1/30/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


class SearchCollectionViewDatasource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    let cardsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 40.0, left: 15.0, bottom: 40.0, right: 15.0)
    let cardSize = CGSize(width: 63, height: 88)
    var cardSizeRatio: CGFloat {
        return cardSize.height/cardSize.width
    }
    
    
    
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
        
        print("cell for path")
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print("will display")
        
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







//
