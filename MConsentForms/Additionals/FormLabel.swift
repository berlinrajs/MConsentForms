//
//  FormLabel.swift
//  AmanaDental
//
//  Created by Office on 4/22/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

class FormLabel: UILabel {

    var bottomBorder : CALayer!
    
    override func layoutSubviews() {
        bottomBorder = bottomBorder == nil ? CALayer() : bottomBorder
        bottomBorder.frame = CGRectMake(0.0, self.frame.size.height - 2, self.frame.size.width, 1.0)
        bottomBorder.backgroundColor = UIColor.blackColor().CGColor
        self.layer.addSublayer(bottomBorder)
    }
}
class VerticalSeperator: UILabel {
    
    var verticalBorder : CALayer!
    
    override func layoutSubviews() {
        verticalBorder = verticalBorder == nil ? CALayer() : verticalBorder
        verticalBorder.frame = CGRectMake(self.frame.size.width/2, 0, 1.0, self.frame.size.height)
        verticalBorder.backgroundColor = UIColor.blackColor().CGColor
        self.layer.addSublayer(verticalBorder)
    }
}