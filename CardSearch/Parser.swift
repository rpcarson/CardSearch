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
    
    func imageFromURL(imageURL: String, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            if let url = URL(string: imageURL) {
                do {
                    let data = try Data(contentsOf: url)
                    if let image = UIImage(data: data) {
                        completion(image)
                    }
                    
                } catch {
                    print("imageFromURL failed to retireve image data")
                }
            } else {
                print("imageFromURL failed to create URL from string")

            }
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
    
    
    func getImage(imageURL: String) -> UIImage? {
        
        print("beginning getImage")
        
        var uiImage: UIImage?
        
        if let url = URL(string: imageURL) {
            
            DispatchQueue.global(qos: .background).async {
                
                do {
                    
                    let imageData = try Data(contentsOf: url)
                    
                    let image = UIImage(data: imageData)
                    
                    uiImage = image
                    print("image set")
                    
                } catch {
                    print("bad image data")
                   
                }
            }
        }
        
        print("returning nil")
        return uiImage
        
    }
    
    
    func getUniqueCardsWithNameAndID(data: [String:Any]) -> [String:Any]? {
        
        var uniqueCards = [String:Int]()
        
        if let cards = data["cards"] as? [[String:Any]] {
            print("GUCO: cards")
            
            for card in cards {
                if let name = card["name"] as? String {
                    if let id = card["multiverseid"] as? Int {
                        if !uniqueCards.keys.contains(name) {
                            uniqueCards.updateValue(id, forKey: name)
                            print("unique card added name:\(name), id: \(id)")
                        }
                    }
                }
                
                
            }
            
        }
        
        return uniqueCards
    }
    
    func removeDuplicates(data: [String:Any]) -> [[String:Any]]?  {
        
        var uniqueArray = [[String:Any]]()
        
        if let cards = data["cards"] as? [[String:Any]] {
            print("GUCO: cards")
            
            for card in cards {
                
                var uniqueCards = [String:Any]()
                
                if let name = card["name"] as? String {
                    if !uniqueCards.keys.contains(name) {
                        if let info = card[name] {
                            uniqueCards.updateValue(info, forKey: name)
                            print("Unique card addded")
                        }
                        
                    }
                }
                uniqueArray.append(uniqueCards)
                
            }
            
            
        }
        
        return uniqueArray
        
    }
    
    func createCardsFromJSON(data: [String:Any]) -> [Card]? {
        
        var cardArray = [Card]()
        var newCard = Card()
        
        if let cards = data["cards"] as? [[String:Any]] {
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
                
                if let imageURL = card["imageUrl"] as? String {
                    newCard.imageURL = imageURL
                }
                
                if let id = card["multiverseid"] as? Int {
                    newCard.id = id
                }
                
                cardArray.append(newCard)
                
            }
            
        }
        
        return cardArray
        
        
    }
    
    
    
    func createCard(data: [String:Any]) -> [Card]? {
        var cardArray = [Card]()
        
        var uniqueNames = [String]()
        
        if let cards = data["cards"] as? [[String:Any]] {
            
            for card in cards {
                
                var newCard = Card()

                if let name = card["name"] as? String {
                    if !uniqueNames.contains(name) {
                        
                        uniqueNames.append(name)
                        
                        newCard.name = name
                        
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
                        
                        if let imageURL = card["imageUrl"] as? String {
                            newCard.imageURL = imageURL
                        }
                        
                        if let id = card["multiverseid"] as? Int {
                            newCard.id = id
                        }
                        
                    }
                }
                
                
                
                cardArray.append(newCard)
            }
        }
        
        return cardArray
    }
    
    
    
    
    
    func createCardsRemovingDuplicatesByName(data: [String:Any]) -> [Card]? {
        
        var cardArray = [Card]()
        var newCard = Card()
        
        var uniqueNames = [String]()
        
        if let cards = data["cards"] as? [[String:Any]] {
            
            for card in cards {
                
                if let name = card["name"] as? String {
                    if !uniqueNames.contains(name) {
                        
                        uniqueNames.append(name)
                        
                        newCard.name = name
                        
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
                        
                        if let imageURL = card["imageUrl"] as? String {
                            newCard.imageURL = imageURL
                        }
                        
                        if let id = card["multiverseid"] as? Int {
                            newCard.id = id
                        }
                        
                        cardArray.append(newCard)
                        print("card added to array")
                        
                    } else { print("duplictae skipped") }
                }
                
            }
        }
        
        return cardArray
    }
    
    
    func sortJSONByRemovingDuplicateNames(json: [String:Any]) -> [String:Any] {
        
        var uniqueData = [[String:Any]]()
        
        var uniqueNames = [String]()
        
        if let cards = json["cards"] as? [[String:Any]] {
            
            for card in cards {
                
                if let name = card["name"] as? String {
                    if !uniqueNames.contains(name) {
                        uniqueNames.append(name)
                        
                        uniqueData.append(card)
                        print("sortJSONByRemovingDuplicateNames unique card appended: \(name)")
                        
                    }
                
                }
                
            }
            
        }
        
        let package: [String:Any] = ["cards":uniqueData]
        print("sortJSONByRemovingDuplicateNames success: returning package")
        return package
    }
    
    
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
            
            if let imageURL = card["imageUrl"] as? String {
                newCard.imageURL = imageURL
            }
            
            if let id = card["multiverseid"] as? Int {
                newCard.id = id
            }
            
            cardArray.append(newCard)
            
            }
            
            return cardArray
        }
        
    }
    
    


