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
    
    var searchParameters = [SearchParameter:String]()
    
    
    @IBOutlet weak var parameterTableView: UITableView!

    
    @IBOutlet weak var colorPicker: OptionsPicker!
    @IBOutlet weak var typePicker: OptionsPicker!
    @IBOutlet weak var cmcPicker: OptionsPicker!
    @IBOutlet weak var setPicker: OptionsPicker!
    
    @IBOutlet var addParameterButtons: [ParameterButton]!
    @IBOutlet var removeParameterButtons: [ParameterButton]!
    
    @IBAction func addRemoveParameter(sender: ParameterButton) {
        guard let id = ID(rawValue: sender.tag) else {
            print("addParameter:sender  - invalid button id") ; return
        }
        
        switch id {
        case ID.colorPicker:
            if sender.buttonFunc == .add {
                print("addcolorparam")
            } else {
                print("remove color parameter")
            }
        case ID.setPicker:
            if sender.buttonFunc == .add {
                print("add set parameter")
            } else {
                print("remove set parameter")
            }
        case ID.typePicker:
            if sender.buttonFunc == .add {
                print("add type parameter")
            } else {
                print("remove type parameter")
            }
        case ID.cmcPicker:
            if sender.buttonFunc == .add {
                print("add cmc parameter")
            } else {
                print("remove cmc parameter")
            }
        }
    }
    
    
    @IBAction func backToCollectionView() {
        print("backToCollectionView called")
        let index = cmcPicker.selectedRow(inComponent: 0)
        
        print(cmcPicker.data.count)
        
        if let limit = Int(cmcPicker.data[index]) {
            print("pickerview selection \(limit)")
            collectionView?.resultsLimit = limit
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func configPickers() {
        colorPicker.configPicker(pickerType: .color)
        typePicker.configPicker(pickerType: .type)
        cmcPicker.configPicker(pickerType: .cmc)
        setPicker.configPicker(pickerType: .set)
    }
    func configButtons() {
        for button in addParameterButtons {
            button.buttonFunc = .add
        }
        for button in removeParameterButtons {
            button.buttonFunc = .remove
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configPickers()
        configButtons()
        
        
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






