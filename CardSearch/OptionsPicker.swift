//
//  OptionsPicker.swift
//  CardSearch
//
//  Created by Reed Carson on 1/22/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

enum PickerType: String {
    case color
    case cmc
    case set
    case type
}

class OptionsPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerType: PickerType = .color
    
    var parameterType: SearchParameter {
        return SearchParameter(rawValue: pickerType.rawValue)!
    }
    
    var data: [String] {
        switch pickerType {
        case .color: return ["red", "green", "blue", "white", "black", "colorless"]
        case .cmc: return ["1","2","3","4","5","6","7","8","9"]
        case .set: return ["DTK","FRF","KTK","ORI","BFZ","OGW","SOI","EMN","KLD"]
        case .type: return ["creature", "sorcery", "instant", "land", "fuck planeswalkers"]
        }
    }
    
    func configPicker(pickerType: PickerType) {
        self.pickerType = pickerType
        self.dataSource = self
        self.delegate = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
