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

    
    @IBOutlet weak var colorPicker: OptionsPicker!
    @IBOutlet weak var typePicker: OptionsPicker!
    @IBOutlet weak var cmcPicker: OptionsPicker!
    @IBOutlet weak var setPicker: OptionsPicker!
    
    @IBOutlet var addParameterButtons: [ParameterButton]!
    @IBOutlet var removeParameterButtons: [ParameterButton]!
    
    @IBOutlet weak var colorButton: ParameterButton!
    @IBOutlet weak var typeButton: ParameterButton!
    @IBOutlet weak var setButton: ParameterButton!
    @IBOutlet weak var cmcButton: ParameterButton!
    
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
               // print("state set")
            }
           
        }  
      
    }
    
    @IBAction func backToCollectionView() {
        
        updateLogicStateForParameters()
        
        collectionView?.searchManager.updateParameters(parameters: parameters)
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func configPickers() {
        colorPicker.configPicker(pickerType: .color)
        typePicker.configPicker(pickerType: .type)
        cmcPicker.configPicker(pickerType: .cmc)
        setPicker.configPicker(pickerType: .set)
   }
   
    func configButtons() {
        colorButton.setPicker(picker: colorPicker)
        setButton.setPicker(picker: setPicker)
        cmcButton.setPicker(picker: cmcPicker)
        typeButton.setPicker(picker: typePicker)
    }
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        
        parameterTableView.backgroundColor = UIColor.darkGray
        
        configButtons()
        configPickers()
        
        parameterTableView.allowsSelection = false
        
        
    }

}






