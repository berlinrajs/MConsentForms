//
//  PDTableView.swift
//  FutureDentistry
//
//  Created by Leojin Bose on 03/02/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

protocol PDTableViewDelegate {
    func selectedValue(value : String, id : Int , table : UITableView)
}


class PDTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var delegatePDTableView : PDTableViewDelegate?
    
    var arrayValues : [String]?
    var useUppercaseString : Bool! = true
    
    override func awakeFromNib() {
        
        self.delegate = self
        self.dataSource = self
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayValues != nil ? arrayValues!.count : 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellList", forIndexPath: indexPath)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = useUppercaseString == true ? arrayValues![indexPath.row].uppercaseString : arrayValues![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegatePDTableView?.selectedValue(arrayValues![indexPath.row], id: indexPath.row, table: self)
    }
}
