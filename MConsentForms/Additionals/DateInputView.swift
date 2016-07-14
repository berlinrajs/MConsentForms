//
//  DateInputView.swift
//  PeopleCenter
//
//  Created by SRS Web Solutions on 27/04/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

class DateInputView: UIView {
    var textField: UITextField!
    var datePicker: UIDatePicker!
    var toolbar: UIToolbar!
    
    var arrayStates: [String]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.datePicker = UIDatePicker(frame: CGRectMake(0, 0, screenSize.width, 260))
        datePicker.addTarget(self, action: #selector(datePickerDateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        self.toolbar = UIToolbar(frame: CGRectMake(0, 0, screenSize.width, 44))
        
        let barbuttonDone = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(donePressed))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil), barbuttonDone]
        
        self.addSubview(datePicker)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func datePickerDateChanged(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = datePicker.datePickerMode == .Time ? "hh:mm a" : "MMM dd, yyyy"
        textField.text = dateFormatter.stringFromDate(datePicker.date).uppercaseString
    }
    func donePressed() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = datePicker.datePickerMode == .Time ? "hh:mm a" : "MMM dd, yyyy"
        textField.text = dateFormatter.stringFromDate(datePicker.date).uppercaseString
        textField.resignFirstResponder()
    }
    class func addDatePickerForTextField(textField: UITextField) {
        
        self.addDatePickerForTextField(textField, minimumDate: nil, maximumDate: NSDate())
    }
    class func addDatePickerForTextField(textField: UITextField, minimumDate: NSDate?, maximumDate: NSDate?) {
        let dateListView = DateInputView(frame: CGRectMake(0, 0, screenSize.width, 260))
        textField.inputView = dateListView
        textField.inputAccessoryView = dateListView.toolbar
        dateListView.textField = textField
        dateListView.datePicker.minimumDate = minimumDate
        dateListView.datePicker.maximumDate = maximumDate
        dateListView.datePicker.datePickerMode = UIDatePickerMode.Date
    }
    
    class func addTimePickerForTextField(textField: UITextField) {
        let dateListView = DateInputView(frame: CGRectMake(0, 0, screenSize.width, 260))
        textField.inputView = dateListView
        textField.inputAccessoryView = dateListView.toolbar
        dateListView.textField = textField
        dateListView.datePicker.datePickerMode = UIDatePickerMode.Time
    }

    class func addDatePickerForTextField(textField: UITextField, minimumDate: NSDate?, maximumDate: NSDate?, mode: UIDatePickerMode, interval: NSInteger) {
        let dateListView = DateInputView(frame: CGRectMake(0, 0, screenSize.width, 260))
        textField.inputView = dateListView
        textField.inputAccessoryView = dateListView.toolbar
        dateListView.textField = textField
        dateListView.datePicker.minimumDate = minimumDate
        dateListView.datePicker.maximumDate = maximumDate
        dateListView.datePicker.datePickerMode = mode
        dateListView.datePicker.minuteInterval = interval
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        dateListView.datePicker.setDate(dateFormatter.dateFromString("12:00")!, animated: true)
    }
}