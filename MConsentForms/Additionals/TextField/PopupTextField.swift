//
//  PopupTextField.swift
//  FusionDental
//
//  Created by Leojin Bose on 5/12/16.
//  Copyright © 2016 SRS. All rights reserved.
//

enum TextFormat : Int {
    case Default = 0
    case SocialSecurity
    case ToothNumber
    case Phone
    case Zipcode
    case Number
    case Date
    case Email
}

import UIKit

class PopupTextField: UIView {

    static let sharedInstance = NSBundle.mainBundle().loadNibNamed("PopupTextField", owner: nil, options: nil).first as! PopupTextField
    
    class func popUpView() -> PopupTextField {
        return NSBundle.mainBundle().loadNibNamed("PopupTextField", owner: nil, options: nil).first as! PopupTextField
    }
    
    @IBOutlet weak var textField: PDTextField!
    @IBOutlet weak var labelTitle: UILabel!
    
    var completion:((PopupTextField,UITextField, Bool)->Void)?
    var textFormat : TextFormat = .Default
    var count : Int!

    
    func show(inViewController: UIViewController, completion : (popUpView: PopupTextField, textField : UITextField, isEdited : Bool) -> Void) {
        self.showWithTitle(labelTitle.text, placeHolder: "TYPE HERE", keyboardType: .Default, textFormat: .Default, inViewController: inViewController, completion: completion)
    }
    
    func showWithTitle(title: String?, placeHolder : String?, keyboardType : UIKeyboardType, textFormat: TextFormat, inViewController: UIViewController, completion : (popUpView: PopupTextField, textField : UITextField, isEdited : Bool) -> Void) {
        textField.text = ""
        labelTitle.text = title
        self.textFormat = textFormat
        if let _ = placeHolder {
            textField.placeholder = placeHolder
        }
        
        textField.keyboardType = keyboardType
        textField.inputView = nil
        textField.inputAccessoryView = nil
        self.completion = completion
//        if inViewController == nil {
//            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            appDelegate.window!.addSubview(self)
//        } else {
            inViewController.view.addSubview(self)
//        }
        
        self.subviews[0].transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        self.subviews[0].transform = CGAffineTransformIdentity
        UIView.commitAnimations()
    }
    
    func showDatePopupWithTitle(title: String?, placeHolder : String?, inViewController: UIViewController, minDate : NSDate?, maxDate : NSDate?, completion : (popUpView: PopupTextField, textField : UITextField, isEdited : Bool) -> Void) {
        textField.text = ""
        labelTitle.text = title
        self.textFormat = .Date
        if let _ = placeHolder {
            textField.placeholder = placeHolder
        }
        DateInputView.addDatePickerForTextField(textField, minimumDate: minDate, maximumDate: maxDate)
        self.completion = completion
        inViewController.view.addSubview(self)
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.window!.addSubview(self)
        self.subviews[0].transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        self.subviews[0].transform = CGAffineTransformIdentity
        UIView.commitAnimations()
    }
    
    func close() {
        self.removeFromSuperview()
    }
    
    @IBAction func buttonActionOK(sender: AnyObject) {
            completion?(self, self.textField, isEdited)
            self.removeFromSuperview()
    }
    
    var isEdited : Bool {
        get {
            return !textField.isEmpty
        }
    }
    var isValidText: Bool {
        get {
            switch self.textFormat {
            case .SocialSecurity:
                return !(isEdited && !textField.text!.isSocialSecurityNumber)
            case .Phone:
                return !(isEdited && !textField.text!.isPhoneNumber)
            case .Zipcode:
                return !(isEdited && !textField.text!.isZipCode)
            case .Email:
                return !(isEdited && !textField.text!.isValidEmail)
            default:
                return true
            }
        }
    }
}


extension PopupTextField : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if self.textFormat == .Phone {
            return textField.formatPhoneNumber(range, string: string)
        } else if self.textFormat == .Zipcode {
            return textField.formatZipCode(range, string: string)
        } else if self.textFormat == .Number {
            return textField.formatNumbers(range, string: string, count: 3)
        } else if self.textFormat == .ToothNumber {
            return textField.formatToothNumbers(range, string: string)
        } else if self.textFormat == .SocialSecurity {
            return textField.formatSocialSecurityNumber(range, string: string)
        }
        return true
    }
    
    
}