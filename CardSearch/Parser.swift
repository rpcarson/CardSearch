//
//  Parser.swift
//  CardSearch
//
//  Created by Reed Carson on 1/13/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


class JSONParser {
    static let parser = JSONParser()
    
    
    func parseSetsJSONData(json: JSONResults) -> [CardSet]? {
        
        var cardSets = [CardSet]()
        
        guard let sets = json["sets"] as? [[String:Any]] else {
            print("JSONParser:parseSetsJSONData - invalid json used")
            return nil
        }
        
        for set in sets {
            var nameString = ""
            var codeString = ""
            var blockString = ""
            
            if let name = set["name"] as? String {
                nameString = name
            }else {
                print("no name")
            }
            if let code = set["code"] as? String {
                codeString = code
            }else {
                print("no code")
            }
            if let block = set["block"] as? String {
                blockString = block
            } else {
                print("no block")
            }
            
            let set = CardSet(name: nameString, code: codeString, block: blockString)
            
            cardSets.append(set)
            print("PARSER - CARD SET APPENEDED: \(nameString), \(codeString), \(blockString)")
            
        }
        
        return cardSets
    }
    
    func createCardImageFor(_ card: Card, completion: (CardImage) -> Void) {
        guard let url = URL(string: card.imageURL) else {
            print("getCardImageFrom(:) bad url ")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            if let image = UIImage(data: data) {
                let cardImage = CardImage(image: image, associatedCardID: card.id)
                ImageStore.images.append(cardImage)
                completion(cardImage)
            }
        } catch {
            print("getCardImageFrom(:) error: \(error) ")
        }
        
    }
    
    
    func getImageNoQueue(imageURL: String) -> UIImage? {
        
        print("beginning getImage")
        
        if let url = URL(string: imageURL) {
            do {
                
                let imageData = try Data(contentsOf: url)
                
                let image = UIImage(data: imageData)
                
                print("image set")
                return image
                
            } catch {
                print("bad image data")
                return nil
                
            }
        }
        
        print("returning nil")
        return nil
        
    }
    
    
    
    
    
    // * IS USED *//
    func sortJSONByRemovingDuplicateNames(json: [String:Any]) -> [String:Any] {
        
        var uniqueData = [[String:Any]]()
        
        var uniqueNames = [String]()
        
        
        
        if let cards = json["cards"] as? [[String:Any]] {
            
            for card in cards {
                
                if let name = card["id"] as? String {
                    if !uniqueNames.contains(name) {
                        if let set = card["set"] as? String  {
                            if !set.contains("p") {
                                uniqueNames.append(name)
                                
                                uniqueData.append(card)
                            }
                        }
                        
                        print("sortJSONByRemovingDuplicateNames unique card appended: \(name)")
                        
                    }
                    
                }
                
            }
            
        }
        
        let package: [String:Any] = ["cards":uniqueData]
        print("sortJSONByRemovingDuplicateNames success: returning package")
        return package
    }
    
    //**ISUSED8**/
    
    
    func createCardsFromCardsData(data: JSONCardData) -> [Card] {
        
        var cardArray = [Card]()
        
        for card in data {
            
            var newCard = Card()
            
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
            
            if let toughness = card["toughness"] as? String {
                newCard.toughness = toughness
            }
            
            if let power = card["power"] as? String {
                newCard.power = power
            }
            
            if let colors = card["colors"] as? [String] {
                newCard.colors = colors
            }
            
            if let flavor = card["flavor"] as? String {
                newCard.flavor = flavor
            }
            
            if let imageURL = card["imageUrl"] as? String {
                newCard.imageURL = imageURL
            }
            
            if let id = card["id"] as? String {
                newCard.id = id
                print("\(newCard.name): MVID: \(id)")
            }
            
            if let set = card["set"] as? String {
                newCard.set = set
            }
            
            if let rulings = card["rulings"] as? [[String:String]] {
                newCard.rulings = rulings
            }
            
            cardArray.append(newCard)
            
        }
        
        return cardArray
    }
    
}




