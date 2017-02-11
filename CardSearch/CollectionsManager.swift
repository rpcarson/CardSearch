//
//  CollectionsManager.swift
//  CardSearch
//
//  Created by Reed Carson on 2/3/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation

protocol DisplayDelegate {
    func didUpdateData()
}



struct CollectionsManager {
    static var sharedManager = CollectionsManager()
        
    private var savedCardData = [Card]()
    
    private var defaultCollection = CardCollection(name: "Favorites")
    private var customCollections = [CardCollection(name: "Test")]
    private var availableCollections = ["Favorites"]
    
    var collections: [CardCollection] {
        var collection = [CardCollection]()
        collection.append(defaultCollection)
        for c in customCollections {
            collection.append(c)
        }
        return collection
    }
    
    func getAvailableCollections() -> [String] {
        return availableCollections
    }
    
    mutating func loadCollections(data: String) {}
    
    mutating func loadFavorites() {
        defaultCollection.cards = RealmManager.sharedManager.getCardsFromResults()
    }
    
    func updateRealmData() {
       // RealmManager.sharedManager.saveCollection(collection: defaultCollection)
    }
    
    mutating func removeFromCollection(card: Card) {
        for (i, c) in defaultCollection.cards.enumerated() {
            if c == card {
                defaultCollection.cards.remove(at: i)
                RealmManager.sharedManager.removeCardModel(card: card)
                // updateRealmData()
                print("Card removed from default collecitn: \(c.name)")
            }
        }
    }
    
    mutating func addCardToCollection(card: Card, collection: String) {
        if collection == "Favorites" {
            defaultCollection.addCard(card)
            RealmManager.sharedManager.saveCardAsModel(card: card, inCollection: "Favorites")
            //updateRealmData()
            print("card added to default collection \(card.name)")
          //  RealmManager.sharedManager.saveCardAsModel(card: card, inCollection: "Favorites")
            
        } else {
            for (i, c) in customCollections.enumerated() {
                if collection == c.name {
                    customCollections[i].addCard(card)
                }
            }
        }
                
      //  print("Card: \(card) added to \(collection)")
    }
    
    mutating func createCollection(name: String) {
        let collection = CardCollection(name: name)
        customCollections.append(collection)
        availableCollections.append(name)
    }
    
    
    
}


struct CardCollection {
    
    let name: String
    
    var cards: [Card]
    
    func getCard(index: Int) -> Card? {
        guard index >= cards.count else { print(" getCard: index out of bounds") ; return nil }
        return cards[index]
    }
    
    mutating func addCard(_ card: Card) {
        cards.append(card)
    }
    func getCards() -> [Card] {
        return cards
    }
    
    init(name: String) {
        self.name = name
        cards = []
    }
    
    
}
