//
//  CardModel.swift
//  CardSearch
//
//  Created by Reed Carson on 1/13/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


struct Card {
    
    var name: String
    var colors: [String]
//    var color: String {
//        var string = ""
//        for c in colors {
//            if c == colors[0] {
//                string += c
//            } else {
//                string += ", \(c)"
//            }
//        }
//        return string
//    }
    
    var cardColor: CardColor {
        guard self.colors.count >= 1 else { print("colorlesss") ; return .colorless }
        
        if self.colors.count > 1 {
            return .multi
        }
        
        switch self.colors[0] {
        case "Red": return .red
        case "Blue": return .blue
        case "Green": return .green
        case "Black": return .black
        case "White": return .white
        default: print("cardColor for \(name): No valid color") ; return .colorless
        }
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
    
    var id: String
    
    var set: String
    
    var otherVersionIDs: [Int]
    
    var image: UIImage? {
        get {
            for x in ImageStore.images {
                if x.associatedCardID == self.id {
                    if self.id == "0" {
                        print("\(name): invalid card ID")
                        return UIImage(named: "Magic_card_back")
                    }
                    print("\(name): Associated Image Found")
                    return x.image
                }
            }
            print("\(name): No Associated Image Found")
           // return UIImage(named: "Magic_card_back")
            return nil
        }
        set {
            let img = CardImage(image: newValue!, cardID: self.id)
            if !ImageStore.images.contains(img) {
               // print("\(name): Adding image to ImageStore")
                ImageStore.images.append(img)
            }
        
        }
        
    }
    
    var rulings: [[String:String]]
    
    var printings: [String]
    
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
        id = "0"
        otherVersionIDs = [0]
        set = "blank"
        rulings = [["none":"none"]]
        printings = ["blank"]
    }

}


extension Card: Equatable {
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}


extension Card {
    
     var realmModel: CardModel {
        return convertToRealmModel()
    }
    
    private func convertToRealmModel() -> CardModel {
        
        let separator = "-"
        let model: CardModel = CardModel()
        
        model.name = self.name
        model.colors = self.colors.joined(separator: separator)
        model.manaCost = self.manaCost
        model.cmc = self.cmc
        model.power = self.power
        model.toughness = self.toughness
        model.type = self.type
        model.types = self.types.joined(separator: separator)
        model.subtypes = self.subtypes.joined(separator: separator)
        model.flavor = self.flavor
        model.imageURL = self.imageURL
        model.rarity = self.rarity
        model.id = self.id
        model.set = self.set
        
        model.otherVersionIDs = (self.otherVersionIDs.map({String($0)}) as [String]).joined(separator: separator)
        
        if let image = self.image {
            if let data: Data = UIImageJPEGRepresentation(image, 1.0) {
                model.imageData = data as NSData
            } else {
                print("RealmManager:saveCardAsModel - data from image failed ")
            }
        }
        
        return model
    }
    
}









//

