//
//  CardSorter.swift
//  CardSearch
//
//  Created by Reed Carson on 1/16/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation


struct CardSorter {
    
    // TODO: - Consolidate remove duplicates functions
    

    
    
    static func removeDuplicatesByName(cards:[Card])->[Card] {
        var uniqueNames = [String]()
        var uniqueCards = [Card]()
        
        for card in cards {
            if !uniqueNames.contains(card.name) {
                uniqueCards.append(card)
                print("uniqe card appended \(card.name)")
            }
            uniqueNames.append(card.name)
        }
        return uniqueCards
    }
    
    static func removeDuplicatesByID(cards: [Card]) -> [Card] {
        var uniqueIDs = [Int]()
        var uniqueCards = [Card]()
        
        for card in cards {
            if !uniqueIDs.contains(card.id) {
                uniqueCards.append(card)
                print("uniqe card appended \(card.id)")
            }
            uniqueIDs.append(card.id)
        }
        return uniqueCards
    }
}
