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
    @IBOutlet  weak var cardImageView: UIImageView!
    
    var isNew = true

    var cardData = Card() {
        didSet {
            if cardData.name != "blank" {
                isNew = false

            }
        }
    }
    
    func setImage(image: UIImage, andDisplay: Bool, completion: (() -> Void)?) {
       // cardData.image = image
        if andDisplay {
            cardImageView.image = cardData.image
            self.setNeedsLayout()
        }
        if completion != nil {
            completion!()
        }
        
    }

}
