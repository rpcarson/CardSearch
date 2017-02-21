//
//  OptionsPicker.swift
//  CardSearch
//
//  Created by Reed Carson on 1/22/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

enum PickerType: String {
    case color = "Color"
    case cmc
    case set = "Set"
    case type = "Type"
    // case subtype = "Subtype"
}

class OptionsPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private static var pickers = [OptionsPicker]()
    static var pickerOrder: [OptionsPicker] {
            return OptionsPicker.pickers.sorted { $0.0.frame.origin.y > $0.1.frame.origin.y }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        OptionsPicker.pickers.append(self)
        self.dataSource = self
        self.delegate = self
    }

    var parameterType: SearchParameter {
        for (i, picker) in OptionsPicker.pickerOrder.enumerated() {
            if self == picker {
             //   pickerID = i
                switch i {
                case 0: return .color
                case 1: return .set
                case 2: return .type
                case 3: return .cmc
                default: return .color
                }
            }
        }
        print("pickerType error")
        return .color
    }
    
//    var parameterType: SearchParameter {
//        return SearchParameter(rawValue: pickerType.rawValue)!
//    }
    
    var data: [String] {
        switch parameterType {
        case .color: return CardSpecifications.colors
        case .cmc: return ["1","2","3","4","5","6","7","8","9","9+"]
        case .set: return ["DTK","FRF","KTK","ORI","BFZ","OGW","SOI","EMN","KLD","AER"]
        case .type: return CardSpecifications.types
        default: print("picker data error") ; return [""]
        }
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
    
    
}
