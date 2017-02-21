//
//  ConfigSearchVC.swift
//  CardSearch
//
//  Created by Reed Carson on 1/19/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit



struct Parameter {
    var logicState: LogicState = ._is
    var parameterType: SearchParameter = .color
    var value = ""
}


class ConfigSearchVC: UIViewController {
    
    var parameters = [Parameter]()
    
    func groupParameters() {
        let sorted = self.parameters.sorted { param1, param2 in
            print("sorted")
            return param1.parameterType.rawValue < param2.parameterType.rawValue
        }
        parameters = sorted
    }
    
    var collectionView: CardCollectionViewController?

    @IBOutlet weak var parameterTableView: UITableView!
    
    @IBOutlet var parameterPickers: [OptionsPicker]!

    @IBOutlet weak var addParamOne: ParameterButton!
    @IBOutlet weak var addParamTwo: ParameterButton!
    @IBOutlet weak var addParamThree: ParameterButton!
    @IBOutlet weak var addParamFour: ParameterButton!

    @IBAction func clearParameters() {
        parameters.removeAll()
        parameterTableView.reloadData()
    }
    
    @IBAction func addParameter(sender: ParameterButton) {
        
        var parameter = Parameter()

        guard let picker = sender.associatedPicker else {
            print("addParamter: bad picker")
            return
        }
        
        let pickerIndex = picker.selectedRow(inComponent: 0)
        let value = (picker.data[pickerIndex]) as String
        parameter.parameterType = picker.parameterType
        parameter.value = value
        
        parameters.append(parameter)
        parameterTableView.reloadData()

    }
    
    
    func updateLogicStateForParameters() {
        for (i, _) in parameters.enumerated() {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = parameterTableView.cellForRow(at: indexPath) as? ParameterCell {
                let state = cell.logicState
                parameters[i].logicState = state
            }
           
        }  
      
    }
    
    @IBAction func backToCollectionView() {
        
        updateLogicStateForParameters()
        
        collectionView?.searchManager.updateParameters(parameters: parameters)
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        
        parameterTableView.backgroundColor = UIColor.darkGray
        
        addParamOne.associatedPicker = OptionsPicker.pickerOrder[0]
        addParamTwo.associatedPicker = OptionsPicker.pickerOrder[1]
        addParamThree.associatedPicker = OptionsPicker.pickerOrder[2]
        addParamFour.associatedPicker = OptionsPicker.pickerOrder[3]

        parameterTableView.allowsSelection = false
        

    }

}






