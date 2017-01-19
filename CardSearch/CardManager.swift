//
//  CardManager.swift
//  CardSearch
//
//  Created by Reed Carson on 1/18/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation


class CardManager {
    
    var cards = [Card]()
    
    func generateCardImages() {
        for (index, _) in cards.enumerated() {
            let card = cards[index]
            if card.image == nil {
                JSONParser.parser.imageFromURL(imageURL: card.imageURL) {
                    result in
                    self.cards[index].image = result
                }
            }
        }
    }
    
    
    
}
