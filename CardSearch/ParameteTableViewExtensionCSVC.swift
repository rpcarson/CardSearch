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

class ParameterCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var andSelector: ParameterCellLogicSelector!
    @IBOutlet weak var orSelector: ParameterCellLogicSelector!
    @IBOutlet weak var notSelector: ParameterCellLogicSelector!
    
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




