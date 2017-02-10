//
//  RealmDB.swift
//  CardSearch
//
//  Created by Reed Carson on 2/10/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit
import RealmSwift




class CardModel: Object {
    
    var collection: String = ""
    
    var name: String = ""
    var colors: String = ""
    var manaCost: String = ""
    var cmc: Int = 0
    var power: String = ""
    var toughness: String = ""
    var type: String = ""
    var types: String = ""
    var subtypes: String = ""
    var flavor: String = ""
    var imageURL: String = ""
    var rarity: String = ""
    var id: Int = 0
    var set: String = ""
    var otherVersionIDs: String = ""
    var imageData: NSData = NSData()
    
}


final class RealmManager {
    static let sharedManager = RealmManager()
    
//   private let realm: Realm? = {
//        var _realm: Realm
//        do {
//           try _realm = Realm()
//            return _realm
//        } catch {
//            print("let realm catch")
//            return nil
//        }
//    }()
    
    var savedCards: List<CardModel> = List()
    
    private init() {}
    
    func saveCardModels() {
        
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(savedCards)
                print("SHIT SAVED")
            }
        } catch {
            print("LOL PFFFFFFFFF CHANGS")
        }
    }
    
    func loadCardModels() {
      
         let realm = try! Realm()
        
        let models = realm.objects(CardModel.self)
            for m in models {
                savedCards.append(m)
        
           // print("no modeulz")
            //handle eerrorr
        }
        
        print(savedCards)
    }
    func getCards() -> [Card] {
        var cards = [Card]()
        for model in savedCards {
            cards.append(createCardFrom(model: model))
        }
        return cards
    }
    
    func saveCardAsModel(card: Card, inCollection: String) {
        
        let model = createModelFrom(card: card)
        model.collection = inCollection
        
        savedCards.append(model)
        
        print("RMAN:saveCardAsModel - appended \(model)\n")
        
        print("RMAN: savedCards count - \(savedCards.count)")
        
    }
    
    private func createCardFrom(model: CardModel) -> Card {
        
        var card = Card()
        
        card.name = model.name
        
        card.colors = model.colors.components(separatedBy: separator)
            
        card.manaCost = model.manaCost
        card.cmc = model.cmc
        card.power = model.power
        card.toughness = model.toughness
        card.type = model.type
        card.types = model.types.components(separatedBy: separator)
        card.subtypes = model.subtypes.components(separatedBy: separator)
        card.flavor = model.flavor
        card.imageURL = model.imageURL
        card.rarity = model.rarity
        card.id = model.id
        card.set = model.set
        
        let array = model.otherVersionIDs.components(separatedBy: separator)
        var intArray = [Int]()
        for str in array {
            if let int = Int(str) {
                intArray.append(int)
            }
        }
        card.otherVersionIDs = intArray
        
        if let image = UIImage(data: (model.imageData as Data)) {
            card.image = image
        } else {
            print("RealmManager:createCardFromModel - image from data fail")
        }
        
        
        print("RMAN:createCardfrommodel: \(card)")
        return card
    }
    
    private func createModelFrom(card: Card) -> CardModel {
        let model: CardModel = CardModel()
        
        model.name = card.name
        model.colors = card.colors.joined(separator: separator)
        model.manaCost = card.manaCost
        model.cmc = card.cmc
        model.power = card.power
        model.toughness = card.toughness
        model.type = card.type
        model.types = card.types.joined(separator: separator)
        model.subtypes = card.subtypes.joined(separator: separator)
        model.flavor = card.flavor
        model.imageURL = card.imageURL
        model.rarity = card.rarity
        model.id = card.id
        model.set = card.set
        
//        var strArray = [String]()
//        for int in card.otherVersionIDs {
//            if let str = String(Int) {
//                strArray.append(str)
//            }
//        }
//        

        model.otherVersionIDs = (card.otherVersionIDs.map({String($0)}) as [String]).joined(separator: separator)
        
        if let image = card.image {
            if let data: Data = UIImageJPEGRepresentation(image, 1.0) {
                model.imageData = data as NSData
            } else {
                 print("RealmManager:saveCardAsModel - data from image failed ")
            }
        }
        
        print("RMAN: create model form card: \(model)")
        
        return model
    }
    
    private let separator = "-"
}







//





