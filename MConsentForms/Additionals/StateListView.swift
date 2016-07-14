//
//  StateListView.swift
//  TotalHealthDental
//
//  Created by Leojin Bose on 4/23/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

class StateListView: UIView {
    var textField: UITextField!
    var pickerView: UIPickerView!
    var toolbar: UIToolbar!
    
    var arrayStates: [String]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.pickerView = UIPickerView(frame: CGRectMake(0, 0, screenSize.width, 260))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        
        self.toolbar = UIToolbar(frame: CGRectMake(0, 0, screenSize.width, 44))
        
//        toolbar.translatesAutoresizingMaskIntoConstraints = false
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
//        let buttonDone = UIButton(frame: CGRectMake(0, 0, 80, 44))
//        buttonDone.setTitle("Done", forState: UIControlState.Normal)
//        buttonDone.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        buttonDone.addTarget(self, action: "donePressed", forControlEvents: UIControlEvents.TouchUpInside)
        
//        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        
        let barbuttonDone = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(donePressed))
        barbuttonDone.tintColor = UIColor.blackColor()
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil), barbuttonDone]
        
        let plist = NSBundle.mainBundle().pathForResource("USStateAbbreviations", ofType: "plist")
        let states = NSDictionary(contentsOfFile: plist!)
        arrayStates = states?.allKeys.sort({ (obj1, obj2) -> Bool in
            let state1 = obj1 as! String
            let state2 = obj2 as! String
            return state1 < state2
        }) as! [String]
        
        self.addSubview(pickerView)
//        self.addSubview(toolbar)
        
//        let top:NSLayoutConstraint = NSLayoutConstraint(item: toolbar, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
//        
//        let bottom:NSLayoutConstraint = NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.TopMargin, relatedBy: NSLayoutRelation.Equal, toItem: toolbar, attribute: NSLayoutAttribute.BottomMargin, multiplier: 1, constant: 0)
//        
//        let pickerCenterX:NSLayoutConstraint = NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0);
//        
//        let toolCenterX:NSLayoutConstraint = NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0);
//        
//        NSLayoutConstraint.activateConstraints([top, bottom, pickerCenterX, toolCenterX])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func donePressed() {
        let plist = NSBundle.mainBundle().pathForResource("USStateAbbreviations", ofType: "plist")
        let states = NSDictionary(contentsOfFile: plist!)
        textField.text = states?.valueForKey(arrayStates[pickerView.selectedRowInComponent(0)]) as? String
        textField.resignFirstResponder()
    }
    class func addStateListForTextField(textField: UITextField) {
        let stateListView = StateListView(frame: CGRectMake(0, 0, screenSize.width, 260))
        textField.inputView = stateListView
        textField.inputAccessoryView = stateListView.toolbar
        textField.text = "MN"
        stateListView.pickerView.reloadAllComponents()
        
        stateListView.textField = textField
    }
}
extension StateListView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayStates.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayStates[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let plist = NSBundle.mainBundle().pathForResource("USStateAbbreviations", ofType: "plist")
        let states = NSDictionary(contentsOfFile: plist!)
        textField.text = states?.valueForKey(arrayStates[pickerView.selectedRowInComponent(0)]) as? String
    }
}
