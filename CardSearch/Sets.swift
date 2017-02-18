//
//  Sets.swift
//  CardSearch
//
//  Created by Reed Carson on 2/2/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import Foundation

struct Block {
    private let unspecifiedBlock = "unspecifiedBlock"
    
    let name: String
    let sets: [SetInfo]
    
    subscript(_ value: String) -> Block? {
        get {
            guard name == value else { return nil }
            return self
        }
    }
    
    init(name: String, sets: [SetInfo]) {
        self.sets = sets
        if name == "" {
            self.name = unspecifiedBlock
        } else {
            self.name = name
        }
    }
}

struct SetInfo {
    let name: String
    let code: String
}

struct CardSet {
    var name: String
    var code: String
    var block: String

}

struct SetsData {
    var allSets = [CardSet]()
    var currentStandardLegalSets = [CardSet]()
    var blocks = [Block]()
    
    func getBlocksFromSetData(sets: [CardSet]) -> [Block] {
        var bloxDict = [String:[SetInfo]]()
        var blocks = [Block]()
        
        for set in sets {
            let setInfo = SetInfo(name: set.name, code: set.code)
            if !bloxDict.keys.contains(set.block) {
                bloxDict.updateValue([], forKey: set.block)
            }
            if bloxDict[set.block] != nil {
                bloxDict[set.block]?.append(setInfo)
            }
        }
        
        for dict in bloxDict {
            let block = Block(name: dict.key, sets: dict.value)
            blocks.append(block)
        }
        
        return blocks
        
    }
    
}









//
