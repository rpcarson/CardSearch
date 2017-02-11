//
//  CardModel.swift
//  CardSearch
//
//  Created by Reed Carson on 1/13/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


extension Card: Equatable {
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}


struct Card {
    
    
    
    var name: String
    
    var colors: [String]
    
    var color: String {
        var string = ""
        for c in colors {
            if c == colors[0] {
                string += c
            } else {
                string += ", \(c)"
            }
        }
        return string
    }

    
    var manaCost: String
    var cmc: Int
    
    var power: String
    var toughness: String
    
    var type: String
    var types: [String]
    var subtypes: [String]
    
    var flavor: String
    
    var imageURL: String
    
    var rarity: String
    
    var id: Int
    
    var set: String
    
    var otherVersionIDs: [Int]
    
    var image: UIImage?


    
    init() {
        name = "blank"
        colors = ["blank"]
        manaCost = "blank"
        cmc = 0
        power = "0"
        toughness = "0"
        type = "blank"
        types = ["blank"]
        subtypes = ["blank"]
        flavor = "blank"
        imageURL = "blank"
        rarity = "blank"
        id = 0
        otherVersionIDs = [0]
        set = "blank"
    }
    
}

