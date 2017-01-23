//
//  ParameterButton.swift
//  CardSearch
//
//  Created by Reed Carson on 1/22/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit

enum ButtonFunc {
    case add
    case remove
}

class ParameterButton: UIButton {
    
    var associatedPicker: OptionsPicker?
    
    func setPicker(picker: OptionsPicker) {
        associatedPicker = picker
    }

    var buttonFunc: ButtonFunc = .add

}
