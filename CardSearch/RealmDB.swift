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
    dynamic var id: Int = 0
    dynamic var set: String = ""
    dynamic var otherVersionIDs: String = ""
    dynamic var imageData: NSData = NSData()
    
}


final class RealmManager {
    static let sharedManager = RealmManager()
    private init() {}
    
    var savedCards: List<CardModel> = List()
    
    private var realm: Realm? {
        var _realm: Realm? = nil
        do {
           try _realm = Realm()
        } catch {
            print("Error instantiating realm instance")
        }
        let message = _realm != nil ? "success" : "fail"
        print("Realm Instance: \(message)")
        return _realm
    }
    
    lazy var dataResults: Results<CardModel>? = {
       return self.realm?.objects(CardModel.self)
    }()
    
  
    
    private func saveCardModels() {
        do {
            try self.realm?.write {
                self.realm?.add(savedCards)
                print("SHIT SAVED")
            }
        } catch {
            print("LOL PFFFFFFFFF CHANGS")
        }
    }

    func getCardsFromResults() -> [Card] {
        var cards = [Card]()
        if let cardModels = dataResults {
            print("RMAN:getCardFromResults - dataResults found")
            for model in cardModels {
                cards.append(createCardFrom(model: model))
            }
        } else {
            print("RMAN:getCardFromResults - no data found")
        }

        return cards
    }
    
    func saveCardAsModel(card: Card, inCollection: String) {
        
        let model = createModelFrom(card: card)
        model.collection = inCollection
        
        savedCards.append(model)
        
        saveCardModels()
        
      //  print("RMAN:saveCardAsModel - appended \(model)\n")
        
      //  print("RMAN: savedCards count - \(savedCards.count)")
        
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
        
        
       // print("RMAN:createCardfrommodel: \(card)")
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

        model.otherVersionIDs = (card.otherVersionIDs.map({String($0)}) as [String]).joined(separator: separator)
        
        if let image = card.image {
            if let data: Data = UIImageJPEGRepresentation(image, 1.0) {
                model.imageData = data as NSData
            } else {
                 print("RealmManager:saveCardAsModel - data from image failed ")
            }
        }
        
       // print("RMAN: create model form card: \(model)")
        
        return model
    }
    
    private let separator = "-"
}


//MARK: - card helpers
extension RealmManager {
    
    
}







//





