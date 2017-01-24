//
//  ConfigSearchVC.swift
//  CardSearch
//
//  Created by Reed Carson on 1/19/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

enum ID: Int {
    case colorPicker = 1
    case setPicker = 2
    case typePicker = 3
    case cmcPicker = 4
}


class ConfigSearchVC: UIViewController {
    
    var collectionView: CardCollectionViewController?
    
    var searchParameters = [[String:String]]() {
        didSet {
            parameterTableView.reloadData()
        }
    }
    
    var parametersWithLogicState = [[String:[String:String]]]()
    
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
    
   
    
    @IBAction func addParameter(sender: ParameterButton) {
        
        guard let picker = sender.associatedPicker else {
            print("addParamter: bad picker")
            return
        }
        
        let pickerIndex = picker.selectedRow(inComponent: 0)
        
        let value = (picker.data[pickerIndex]) as String
        
        let searchParameter = picker.parameterType.rawValue
        
        let parameter: [String:String] = [searchParameter:value]
        
        searchParameters.append(parameter)
        
    }
    
    func getLogicState() {
        
        var i = -1
        for x in searchParameters {
            i += 1
            
            if i >= 0 {
                let indexPath: IndexPath = IndexPath(row: i, section: 0)
                let cell = parameterTableView.cellForRow(at: indexPath) as! ParameterCell
                let state = cell.logicState.rawValue
                parametersWithLogicState.append([state:x])
                
            }
            
        }
        
        
       
      
    }
    
  
    @IBAction func backToCollectionView() {
        
        print(searchParameters)
        
        getLogicState()
        
        print(parametersWithLogicState)
        
        
       // collectionView?.searchManager.search.parameters = searchParameters
        
        
       // self.dismiss(animated: true, completion: nil)
        
    
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
        
        configButtons()
        configPickers()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}






