//
//  SavedCardsLayout.swift
//  CardSearch
//
//  Created by Reed Carson on 2/10/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


extension SavedCollectionsCVC: UICollectionViewDelegateFlowLayout {
    
    var cardsPerRow: CGFloat {
       return 3
    }
    var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    var cardSize: CGSize {
        return CGSize(width: 63, height: 88)
    }
    var cardSizeRatio: CGFloat {
        return cardSize.height/cardSize.width
    }
    
    var paddingSpace: CGFloat {
     return (sectionInsets.left * (cardsPerRow + 1))
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let availableWidth = UIScreen.main.bounds.width - paddingSpace
        let widthPerItem = availableWidth / cardsPerRow
        let height = widthPerItem * cardSizeRatio
        
        return CGSize(width: widthPerItem, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    
    
}
