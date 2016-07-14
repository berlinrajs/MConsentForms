//
//  PDView.swift
//  WestgateSmiles
//
//  Created by Leojin Bose on 2/25/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

class PDView: UIView {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.borderColor = borderColor.CGColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    
    var borderColor: UIColor = UIColor.whiteColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    var cornerRadius: CGFloat = 3.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

}
