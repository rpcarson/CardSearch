//
//  DetailBorder.swift
//  CardSearch
//
//  Created by Reed Carson on 2/12/17.
//  Copyright © 2017 Reed Carson. All rights reserved.
//

import UIKit


class DetailBorder: UIView {
    
    var borderColor: UIColor = .red
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let insetRect = rect.insetBy(dx: 10, dy: 10)
        let insetPath = UIBezierPath(rect: insetRect)
        let rectanglePath = UIBezierPath(rect: rect)
        
        borderColor.set()
        context?.addPath(rectanglePath.cgPath)
        context?.setLineWidth(20)
        context?.strokePath()
        UIColor.darkGray.set()
        context?.setLineWidth(4)
        context?.addPath(insetPath.cgPath)
        context?.strokePath()
       
        clipsToBounds = true

    }
}
