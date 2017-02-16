//
//  TypesAndKinds.swift
//  CardSearch
//
//  Created by Reed Carson on 2/13/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation


enum CardColor {
    case red
    case blue
    case black
    case white
    case green
    case colorless
    case multi
}

struct CardSpecifications {
    static let types =
        
        [
            "Artifact",
            "Conspiracy",
            "Creature",
            "Enchantment",
            "Instant",
            "Land",
            "Phenomenon",
            "Plane",
            "Planeswalker",
            "Scheme",
            "Sorcery",
            "Tribal",
            "Vanguard"
    ]
    
    static let colors = [
        "Red",
        "Blue",
        "Green",
        "Black",
        "White",
        "Colorless"
    ]
    
}

