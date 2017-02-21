//
//  ParameterButton.swift
//  CardSearch
//
//  Created by Reed Carson on 1/22/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


@IBDesignable class ParameterButton: UIButton {
    
    
    var associatedPicker: OptionsPicker?

    
    @IBInspectable var cornerRad: CGFloat = 1

    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let visibleContentOffset: CGFloat = 10
        
        let radius = rect.size.width/2 - visibleContentOffset

        let center = CGPoint(x: rect.size.width/2, y: rect.size.height/2)
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        UIColor.green.set()
    
        context?.addPath(circlePath.cgPath)
        
        context?.fillPath()
        
        UIColor.blue.set()
        
        context?.addPath(circlePath.cgPath)
        
        context?.setLineWidth(5)
        
        context?.strokePath()

        clipsToBounds = true
        
        backgroundColor = UIColor.clear
        
    }
    
//    static private var buttons = [ParameterButton]()
//    static private var buttonOrder: [ParameterButton] {
//        return ParameterButton.buttons.sorted{
//            $0.0.yPosition > $0.1.yPosition
//        }
////        return ParameterButton.buttons.sorted { $0.0.frame.origin.y > $0.1.frame.origin.y }
//    }
 
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        print(ParameterButton.buttons.count)
//        print(self.frame.origin.y)
//        ParameterButton.buttons.append(self)
//        
//    }
    
  //  var yPosition: CGFloat = 0
    
//    var buttonID: Int {
//        var id = 0
//        for (i, button) in ParameterButton.buttonOrder.enumerated() {
//            if self == button {
//                print(i)
//                id = i
//            }
//        }
//        return id
//    }
    
    
//    func setPicker(picker: OptionsPicker) {
//        associatedPicker = picker
//    }


}
