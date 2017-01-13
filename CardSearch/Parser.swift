//
//  Parser.swift
//  CardSearch
//
//  Created by Reed Carson on 1/13/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation

protocol Parser {
    func createCard(data: [String:Any]) -> [Card]?
}


class JSONParser: Parser {
    static let parser = JSONParser()
    
    
    func createCard(data: [String:Any]) -> [Card]? {
        
        var cardArray = [Card]()
        
        if let cards = data["cards"] as? [[String:Any]] {
            
            var newCard = Card()
            
            for card in cards {
                
                if let name = card["name"] as? String {
                    newCard.name = name
                }
                
                if let cmc = card["cmc"] as? Int {
                    newCard.cmc = cmc
                }
                
                if let manaCost = card["manaCost"] as? String {
                    newCard.manaCost = manaCost
                }
                
                if let rarity = card["rarity"] as? String {
                    newCard.rarity = rarity
                }
                
                if let type = card["type"] as? String {
                    newCard.type = type
                }
                
                if let types = card["types"] as? [String] {
                    newCard.types = types
                }
                
                if let subtypes = card["subtypes"] as? [String] {
                    newCard.subtypes = subtypes
                }
                
                if let toughness = card["toughness"] as? Int {
                    newCard.toughness = toughness
                }
                
                if let power = card["power"] as? Int {
                    newCard.power = power
                }
                
                if let colors = card["colors"] as? [String] {
                    newCard.colors = colors
                }
                
                if let flavor = card["flavor"] as? String {
                    newCard.flavor = flavor
                }

                cardArray.append(newCard)
            }
        }
        
       return cardArray
    }
    
}
