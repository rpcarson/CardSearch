//
//  CardManager.swift
//  CardSearch
//
//  Created by Reed Carson on 1/18/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation

typealias JSONResults = [String:Any]
typealias JSONCardData = [[String:Any]]

class CardManager {
    
    var allJSONResults = [String:Any]()
    
    var uniqueJSONResults = JSONResults()
    
    var jsonChunks = [Int:JSONResults]()
   
    var cards = [Card]()

    func getUniqueJSON() {
        uniqueJSONResults = JSONParser.parser.sortJSONByRemovingDuplicateNames(json: allJSONResults)
    }
    
    
    func returnUniqueCards(amount: Int) -> [Card]? {
        
        getUniqueJSON()
        
        var limitedJson = JSONCardData()
        
        if let cards = uniqueJSONResults["cards"] as? [[String:Any]] {
            
            let maxIndex = cards.count - 1
            
            for i in 0..<amount {
                if i <= maxIndex {
                    limitedJson.append(cards[i])
                  
                    
                }
            }
       
        }
        
        let cardData = JSONParser.parser.createCardsFromCardsData(data: limitedJson)
        return cardData
        
    }
    
    func createUniqueCardsWithMaxFromJSON(json: JSONResults, amount: Int) {
        
        allJSONResults = json
        
        getUniqueJSON()
        
        var limitedJson = JSONCardData()
        
        var appended = 0

        
        if let cards = uniqueJSONResults["cards"] as? [[String:Any]] {
            
            let maxIndex = cards.count - 1
            
            
            print(amount)
            print(maxIndex)
            
            
            for i in 0...maxIndex {
                if i <= amount {
                    limitedJson.append(cards[i])
                    appended += 1
                    let card = cards[i]
                    let name = card["name"]
                    print("appending \(name)")
                    
                }
            }
            
        }
        
        let cardData = JSONParser.parser.createCardsFromCardsData(data: limitedJson)
        
        print("cards appened: \(appended)")
        
        cards = cardData
            
    }
    
    func configureWithJSON(json: JSONResults) {
        allJSONResults = json
        
    }
    
    
//    func generateCardImages() {
//        for (index, _) in cards.enumerated() {
//            let card = cards[index]
//            if card.image == nil {
//                JSONParser.parser.imageFromURL(imageURL: card.imageURL) {
//                    result in
//                    self.cards[index].image = result
//                }
//            }
//        }
//    }
    
    init(json: JSONResults) {
        allJSONResults = json
    }
    init() {}

    
}
