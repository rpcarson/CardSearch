//
//  ParameteTableViewExtensionCSVC.swift
//  CardSearch
//
//  Created by Reed Carson on 1/23/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


let parameterCellReuseID = "parameterCell"

class ParameterCell: UITableViewCell {
    
    
    
}




extension ConfigSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: parameterCellReuseID, for: indexPath) as! ParameterCell
        
        cell.backgroundColor = UIColor.blue
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}



