//
//  PDLabel.swift
//  WestgateSmiles
//
//  Created by Leojin Bose on 2/25/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

class PDLabel: UILabel {

    override func awakeFromNib() {
        if attributedText != nil {
            self.enabled = false
            let attrString = NSMutableAttributedString(attributedString: self.attributedText!)
//            attrString.addAttribute(NSFontAttributeName, value: UIFont(name: self.fontFamily, size: self.fontSize)!, range: NSMakeRange(0, attrString.length))
            self.attributedText = attrString
            self.enabled = true
        }
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.borderColor = borderColor.CGColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    
    var borderColor: UIColor = UIColor.clearColor() {
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
