//
//  CollectionsManager.swift
//  CardSearch
//
//  Created by Reed Carson on 2/3/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation


struct CollectionsManager {
    static var sharedManager = CollectionsManager()
    
    var collections = [CardCollection]()
    
    private var favorites = [Card]()
    
    mutating func addCardToFavorites(card: Card) {
        favorites.append(card)
        print("Card: \(card) added to favorites")
    }
    
    
    
}

class Favorites {
    var cards: [Card] = []
}


struct CardCollection {
    
    var collectionName: String
    
    var cards: [Card]
    
    
    
}
