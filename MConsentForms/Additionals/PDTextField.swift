//
//  PDTextField.swift
//  WestgateSmiles
//
//  Created by Leojin Bose on 2/25/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

class PDTextField: UITextField {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.borderColor = enabled ? borderColor.CGColor : borderColor.colorWithAlphaComponent(0.2).CGColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes: [NSForegroundColorAttributeName: enabled ? placeHolderColor : placeHolderColor.colorWithAlphaComponent(0.2)])
        tintColor = enabled ? placeHolderColor : placeHolderColor.colorWithAlphaComponent(0.2)
        clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let leftView = UIView(frame: CGRectMake(0, 0, 5, frame.height))
        self.leftView = leftView
        leftViewMode = .Always
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
    
    var placeHolderColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.5) {
        didSet {
            attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes: [NSForegroundColorAttributeName: placeHolderColor])
            tintColor = placeHolderColor
        }
    }
    
    override var placeholder: String? {
        didSet {
            attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes: [NSForegroundColorAttributeName: placeHolderColor])
            tintColor = placeHolderColor
        }
    }
}
