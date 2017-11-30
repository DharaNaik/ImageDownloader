//
//  CustomSearchBar.swift
//  VerizonImageDownLoader
//
//  Created by Vibhu Kikani on 1/18/17.
//  Copyright © 2017 Verizon. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {


    var preferredFont: UIFont!
    var preferredTextColor: UIColor!

    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        
        searchBarStyle = UISearchBarStyle.prominent
        isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func draw(_ rect: CGRect) {
        for subView in self.subviews
        {
            for subsubView in subView.subviews
            {
                if let textField = subsubView as? UITextField
                {
                    textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search", comment: ""), attributes: [NSForegroundColorAttributeName:UIColor.white])
                    textField.textColor = UIColor.white
                    
                    let glassIconView = textField.leftView as! UIImageView
                    glassIconView.image = glassIconView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                    glassIconView.tintColor = UIColor.white
                    
                    let clearButton = textField.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor.white
                    
                }
            }
        
            
            
//            var startPoint = CGPointMake(0.0, frame.size.height)
//            var endPoint = CGPointMake(frame.size.width, frame.size.height)
//            var path = UIBezierPath()
//            path.moveToPoint(startPoint)
//            path.addLineToPoint(endPoint)
//            
//            var shapeLayer = CAShapeLayer()
//            shapeLayer.path = path.CGPath
//            shapeLayer.strokeColor = preferredTextColor.CGColor
//            shapeLayer.lineWidth = 2.5
//            
//            layer.addSublayer(shapeLayer)
//            
            
        super.draw(rect)
    }
    
    }
}
