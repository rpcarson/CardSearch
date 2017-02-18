//
//  RealmModels.swift
//  CardSearch
//
//  Created by Reed Carson on 2/17/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit
import RealmSwift


class BlockModel: Object {
    dynamic var name: String = ""
    var sets: List<SetModel> = List()
}

class SetModel: Object {
    dynamic var name: String = ""
    dynamic var block: String = ""
    dynamic var code: String = ""
}


class CardModel: Object {
    
    dynamic var collection: String = ""
    
    dynamic var name: String = ""
    dynamic var colors: String = ""
    dynamic var manaCost: String = ""
    dynamic var cmc: Int = 0
    dynamic var power: String = ""
    dynamic var toughness: String = ""
    dynamic var type: String = ""
    dynamic var types: String = ""
    dynamic var subtypes: String = ""
    dynamic var flavor: String = ""
    dynamic var imageURL: String = ""
    dynamic var rarity: String = ""
    dynamic var id: String = ""
    dynamic var set: String = ""
    dynamic var otherVersionIDs: String = ""
    dynamic var imageData: NSData = NSData()
    
}

extension CardModel {
    
    var cardStruct: Card {
        return convertToCardStruct()
    }
    
    private func convertToCardStruct() -> Card {
        
        let separator = "-"
        var card = Card()
        
        card.name = self.name
        card.colors = self.colors.components(separatedBy: separator)
        card.manaCost = self.manaCost
        card.cmc = self.cmc
        card.power = self.power
        card.toughness = self.toughness
        card.type = self.type
        card.types = self.types.components(separatedBy: separator)
        card.subtypes = self.subtypes.components(separatedBy: separator)
        card.flavor = self.flavor
        card.imageURL = self.imageURL
        card.rarity = self.rarity
        card.id = self.id
        card.set = self.set
        
        let array = self.otherVersionIDs.components(separatedBy: separator)
        var intArray = [Int]()
        for str in array {
            if let int = Int(str) {
                intArray.append(int)
            }
        }
        card.otherVersionIDs = intArray
        
        if let image = UIImage(data: (self.imageData as Data)) {
            card.image = image
        } else {
            print("RealmManager:createCardFromModel - image from data fail")
        }
        
        return card
        
    }
    
    
}


