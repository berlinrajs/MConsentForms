//
//  AlertView.swift
//  ProDental
//
//  Created by Leojin Bose on 3/3/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit


class PopupTextView: UIView {
    static let sharedInstance = NSBundle.mainBundle().loadNibNamed("PopupTextView", owner: nil, options: nil).first as! PopupTextView

    
    class func popUpView() -> PopupTextView {
        return NSBundle.mainBundle().loadNibNamed("PopupTextView", owner: nil, options: nil).first as! PopupTextView
    }
    @IBOutlet weak var textView: PDTextView!
    var placeHolder : String!
    var completion:((UITextView, Bool)->Void)?
    
    func show(inViewController: UIViewController, completion : (textView : UITextView, isEdited : Bool) -> Void) {
        self.showWithPlaceHolder("IF YES, TYPE HERE", inViewController: inViewController, completion: completion)
    }
    
    func showWithPlaceHolder(placeHolder : String, inViewController: UIViewController, completion : (textView : UITextView, isEdited : Bool) -> Void) {
        self.placeHolder = placeHolder
        self.completion = completion
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.window!.addSubview(self)
        inViewController.view.addSubview(self)
        self.subviews[0].transform = CGAffineTransformMakeScale(0.1, 0.1)
        textView.text = placeHolder
        textView.textColor = UIColor.lightGrayColor()
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        self.subviews[0].transform = CGAffineTransformIdentity
        UIView.commitAnimations()
    }
    
    @IBAction func buttonActionOK(sender: AnyObject) {
        self.removeFromSuperview()
        completion?(self.textView, isEdited)
    }
    
    var isEdited : Bool {
        get {
            return (textView.text != placeHolder && !textView.isEmpty)
        }
    }
}


extension PopupTextView : UITextViewDelegate {
   
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == placeHolder {
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolder
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
}
