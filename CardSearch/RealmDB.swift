//
//  RealmDB.swift
//  CardSearch
//
//  Created by Reed Carson on 2/10/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit
import RealmSwift

enum RealmError: Error {
    case badData
    case noData
    case badWrite
    case badRealm
    
}




final class RealmManager {
    static let sharedManager = RealmManager()
    private init() {}
    
    var cardModels: List<CardModel> = List()
    var modelsToRemove: List<CardModel> = List()
    
    private func createRealm() throws -> Realm? {
        var realm: Realm? = nil
        do {
            try realm = Realm()
        } catch {
            throw RealmError.badRealm
        }
        let message = realm != nil ? "success" : "fail"
        print("Realm Instance: \(message)")
        return realm
    }
    
    private var realm: Realm? {
        do {
            return try createRealm()
        } catch {
            print(error)
            return nil
        }
    }
    
    
    func loadData() throws {
        
        if let dataResults = realm?.objects(CardModel.self) {
            if dataResults.count == 0 {
                print("no saved data")
                return
            }
            for d in dataResults {
                print("RMAN:loadData loaded: \(d.name)")
                cardModels.append(d)
            }
        } else {
            throw RealmError.noData
        }
    }
    
    
    func saveSetAndBlockModels() throws {
        
    }
    
     func saveCardModels() throws {
        do {
            try self.realm?.write {
                for model in modelsToRemove {
                    if let objects = realm?.objects(CardModel.self) {
                        if  objects.contains(model) {
                            self.realm?.delete(model)
                        }
                    }
                }
                self.realm?.add(cardModels)
                print("SHIT SAVED")
            }
        } catch {
            print("RMAN:saveCardModels - bad write")
            throw RealmError.badWrite
        }
    }

    func getCardsFromResults() -> [Card] {
//        var cards = [Card]()
//        for model in cardModels {
//            cards.append(createCardFrom(model: model))
//            print("getcardfromresults: \(model.name)")
//        }
        return loadCardsFromModels()
    }
    
    func removeCardModel(card: Card) {
        print("Removing \(card.name)")
        for (i, model) in cardModels.enumerated() {
            if model.name == card.name {
                cardModels.remove(objectAtIndex: i)
                modelsToRemove.append(model)
                print("RMAN: card removed \(model.name)")
            }
        }
    }
   private func loadCardsFromModels() -> [Card] {
        var cards = [Card]()
        for model in cardModels {
            cards.append(model.cardStruct)
        }
        return cards
    }
    
    func saveCardAsModel(card: Card, inCollection: String) {
        
//        let model = createModelFrom(card: card)
//        model.collection = inCollection
//        savedCards.append(model)
        cardModels.append(card.realmModel)
        
    }
    
    /*
    private func createCardFrom(model: CardModel) -> Card {
        
        
        let separator = "-"
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
        
        return card
        
    }
    
    private func createModelFrom(card: Card) -> CardModel {
        
        let separator = "-"
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
        
        return model
    }
 */
    
}


//





