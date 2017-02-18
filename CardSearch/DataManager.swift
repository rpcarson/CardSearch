//
//  DataManager.swift
//  CardSearch
//
//  Created by Reed Carson on 2/17/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation

struct CarDDad {
    var cards = [Card]()
}


struct DataManager {
    static let manager = DataManager()
    
    private(set) var savedCards = [Card]()
    mutating func setSavedCards(cards: [Card]) {
        savedCards = cards
    }
    private(set) var setsData = SetsData()
    mutating func setSetsData(data: SetsData) {
        setsData = data
    }
    
}
