//
//  DevSettings.swift
//  CardSearch
//
//  Created by Reed Carson on 2/17/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


//MARK: - dev settings

var testCard: Card = {
    var card = Card()
    card.name = "Allosaurus"
    card.set = "Worst"
    card.colors = ["Blue"]
    card.rulings = [["date":"10-11-12","text":"something more appropriate"],["date":"11-12-13","text":"cant do this or that rule "],["date":"11-12222-13","text":"cant 1212212use to wipe"],["date":"33-12-13","text":"cant useTHISRULING IS ULTRA LONG AND PRObably reflects the elgnth of the average ruling im gonna get back form the json results 3333to"],["date":"11-112122-13","text":"cant use to randomtext randomt radnomdd"]]
    card.image = UIImage(named: "8.png")
    
    return card
}()

let testingSets = false

let testingPageSize = "100"
let testingResultsToDisplay = 100

let autoLoad = false

let useDummyData = false

let useDebuggerCells = true

let useImages = true



//
