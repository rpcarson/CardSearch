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

@IBDesignable class ParameterButton: UIButton {
    
    @IBInspectable var cornerRad: CGFloat = 1
    

    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let visibleContentOffset: CGFloat = 10
        
        let insetRect = rect.insetBy(dx: 5 + visibleContentOffset, dy: 5 + visibleContentOffset)
        
        let radius = rect.size.width/2 - visibleContentOffset

        
        let center = CGPoint(x: rect.size.width/2, y: rect.size.height/2)
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        UIColor.green.set()
        

        
        context?.addPath(circlePath.cgPath)
       // context?.strokePath()
        
        context?.fillPath()
        
        UIColor.blue.set()
        
        context?.addPath(circlePath.cgPath)
        
        context?.setLineWidth(5)
        
        context?.strokePath()
        
        
       // context?.setLineWidth(5)
       // context?.strokeEllipse(in: insetRect)
       // context?.strokeEllipse(in: insetRect)
        
       // context?.strokeEllipse(in: insetRect)
        
      //  layer.cornerRadius = cornerRad
        clipsToBounds = true
        
        backgroundColor = UIColor.clear
        
    }
    
    
    var associatedPicker: OptionsPicker?
    
    func setPicker(picker: OptionsPicker) {
        associatedPicker = picker
    }

    var buttonFunc: ButtonFunc = .add

}
