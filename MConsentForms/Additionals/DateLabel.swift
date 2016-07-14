//
//  DateLabel.swift
//  ProDental
//
//  Created by SRS Web Solutions on 05/05/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

class DateLabel: PDLabel {

    var todayDate: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.whiteColor()
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        
        text = "Tap to date"
        textColor = UIColor.lightGrayColor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelDateTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    func labelDateTapped(sender: AnyObject) {
        text = todayDate
        textColor = UIColor.blackColor()
    }
    
    var dateTapped: Bool {
        get {
            return text != "Tap to date"
        }
    }
}
