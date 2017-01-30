//
//  CardCell.swift
//  CardSearch
//
//  Created by Reed Carson on 1/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet private weak var cardImageView: UIImageView!
    
//    var cardImage: UIImage? {
//        if let image = JSONParser.parser.getImage(imageURL: cardData.imageURL) {
//            print("CardCell cardImage created")
//            return image
//        }
//        print("CardCell cardImage creation failed")
//        return nil
//    }
    
   // var image: UIImage?

    var cardData = Card()
    
    func setImage(image: UIImage, andDisplay: Bool) {
        
        cardData.image = image
        
        if andDisplay {
            cardImageView.image = cardData.image
        }
        
    }

}
