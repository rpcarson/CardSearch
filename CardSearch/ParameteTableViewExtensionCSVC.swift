//
//  ParameteTableViewExtensionCSVC.swift
//  CardSearch
//
//  Created by Reed Carson on 1/23/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


let parameterCellReuseID = "parameterCell"


class ParameterCellLogicSelector: UIButton {
    
    
    
}

enum LogicState: String {
    case _not = "not"
    case _is = "is"
    case _or = "or"  
    case greaterThanOrEqualTo  //3
    case lessThanOrEqualTo //4
    
}


enum LogicSelector {
    case _not

}

class ParameterCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var andSelector: ParameterCellLogicSelector!
    @IBOutlet weak var orSelector: ParameterCellLogicSelector!
    @IBOutlet weak var notSelector: ParameterCellLogicSelector!
    
    var logicState: LogicState = ._is
    
    func toggle(button: ParameterCellLogicSelector, isNumber: Bool = false) {
        
        
        andSelector.isSelected = false
        orSelector.isSelected = false
        notSelector.isSelected = false
        
        button.isSelected = true
    }
    
    @IBAction func selectLogicState(sender: ParameterCellLogicSelector) {

        toggle(button: sender)
        
        print("logic selector pressed")
        guard let name = sender.titleLabel?.text else { print("INVALID NAME") ; return }
        
        switch name {
        case "IS": logicState = ._is ; print("IS")
        case "OR": logicState = ._or ; print("OR")
        case "NOT": logicState = ._not ; print("NOT")
        case "=": logicState = ._is ; print("=")
        case "<": logicState = ._not ; print("<")
        case ">": logicState = ._or ; print(">")
        default: print("NOCASE DEFINED")
        }
        
        
    }
    
}




extension ConfigSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: parameterCellReuseID, for: indexPath) as! ParameterCell
        
        let param = searchParameters[indexPath.row]
        
        
        
        for (_, item) in param.enumerated() {
            
            if item.key == "cmc" {
                cell.orSelector.setTitle("<", for: .normal)
                cell.andSelector.setTitle("=", for: .normal)
                cell.notSelector.setTitle(">", for: .normal)
            }
            
            let title = item.key
            let value = item.value
            cell.label.text = "\(title): \(value)"
        }
        
        cell.andSelector.isSelected = true
        
        cell.backgroundColor = UIColor.gray
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchParameters.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
                searchParameters.remove(at: indexPath.row)
            }
        }
        
    }




