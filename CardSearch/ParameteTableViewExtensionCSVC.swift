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
    case _is = ","
    case _or = "|"
    //    case greaterThanOrEqualTo  //3
    //    case lessThanOrEqualTo //4
    
}

protocol LogicDelegate {
    func didChangeLogicState()
}

class ParameterCell: UITableViewCell {
    
    var logicDelegate: LogicDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var andSelector: ParameterCellLogicSelector!
    @IBOutlet weak var orSelector: ParameterCellLogicSelector!
    @IBOutlet weak var notSelector: ParameterCellLogicSelector!
    
    var logicState: LogicState = ._is
 
    func toggle(button: ParameterCellLogicSelector) {
        andSelector.isSelected = false
        orSelector.isSelected = false
        notSelector.isSelected = false
        
        button.isSelected = true
        print("toggle")
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
    
        logicDelegate?.didChangeLogicState()
        
        
    }
    
}




extension ConfigSearchVC: UITableViewDelegate, UITableViewDataSource, LogicDelegate {
    
    func didChangeLogicState() {
        updateLogicStateForParameters()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: parameterCellReuseID, for: indexPath) as! ParameterCell
        
        let parameter = parameters[indexPath.row]
        
        cell.label.text = "\(parameter.parameterType.rawValue): \(parameter.value)"
        
        cell.logicState = parameter.logicState
        
        switch cell.logicState {
        case ._is: cell.toggle(button: cell.andSelector)
        case ._or: cell.toggle(button: cell.orSelector)
        case ._not: cell.toggle(button: cell.notSelector)

        }
        
        cell.backgroundColor = UIColor.lightGray
        
        cell.logicDelegate = self
        
        return cell
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parameters.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            parameters.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}







