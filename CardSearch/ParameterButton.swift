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
    
    let associatedPicker: PickerType = .color
    var buttonFunc: ButtonFunc = .add

}
