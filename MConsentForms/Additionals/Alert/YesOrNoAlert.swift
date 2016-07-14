//
//  YesOrNoAlert.swift
//  SecureDental
//
//  Created by SRS Web Solutions on 19/05/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

class YesOrNoAlert: UIView {

    static let sharedInstance = NSBundle.mainBundle().loadNibNamed("YesOrNoAlert", owner: nil, options: nil).first as! YesOrNoAlert
    
    class func alertView() -> YesOrNoAlert {
        return NSBundle.mainBundle().loadNibNamed("YesOrNoAlert", owner: nil, options: nil).first as! YesOrNoAlert
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var button1: PDButton!
    @IBOutlet weak var button2: PDButton!
    
    var completion:((Int)->Void)?
    var textFormat : TextFormat!
    var count : Int!
    
    func show(inViewController: UIViewController, completion : (buttonIndex : Int) -> Void) {
        self.showWithTitle(labelTitle.text, button1Title : "YES", button2Title: "NO", inViewController: inViewController, completion: completion)
    }
    
    func showWithTitle(title: String?, button1Title : String, button2Title : String, inViewController: UIViewController, completion : (buttonIndex : Int) -> Void) {
        labelTitle.text = title
        button1.setTitle(button1Title, forState: UIControlState.Normal)
        button2.setTitle(button2Title, forState: UIControlState.Normal)
        self.completion = completion
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        appDelegate.window!.addSubview(self)
        inViewController.view.addSubview(self)
        
        self.subviews[0].transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        self.subviews[0].transform = CGAffineTransformIdentity
        UIView.commitAnimations()
    }
    
    @IBAction func button1Action(sender: AnyObject) {
        self.removeFromSuperview()
        completion?(1)
    }
    @IBAction func button2Action(sender: AnyObject) {
        self.removeFromSuperview()
        completion?(2)
    }
}
