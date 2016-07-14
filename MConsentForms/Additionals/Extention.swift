//
//  Extention.swift
//  WestgateSmiles
//
//  Created by Leojin Bose on 03/02/16.
//  Copyright © 2016 SRS. All rights reserved.
//

import UIKit

public let screenSize = UIScreen.mainScreen().bounds


public func getText(text : String) -> String {
    return "  \(text)  "
}

class Extention: NSObject {
    class func alert(message : String) -> UIAlertController {
        let alertController = UIAlertController(title: "MOON ROAD DENTISTRY", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertOkAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive) { (action) -> Void in
            
        }
        alertController.addAction(alertOkAction)
        return alertController
    }
}


extension NSError {
    
    convenience init(errorMessage : String) {
        self.init(domain: "Error", code: 101, userInfo: [NSLocalizedDescriptionKey : errorMessage])
    }
    
}

extension UILabel {
    func setAttributedText() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        let attributedString = NSAttributedString(string: self.text!,
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSBaselineOffsetAttributeName: NSNumber(float: 0),
                NSFontAttributeName : self.font
            ])
        self.attributedText = attributedString
    }
}


extension UITextField {
    var isEmpty : Bool {
        return self.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
    }
    
    func formatSocialSecurityNumber(range: NSRange, string: String) -> Bool {
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "01234567890").invertedSet)?.last != nil {
            return false
        }
        let newRange = self.text!.startIndex.advancedBy(range.location)..<self.text!.startIndex.advancedBy(range.location + range.length)
        let newString = self.text!.stringByReplacingCharactersInRange(newRange, withString: string)
        
        let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        
        let decimalString : String = components.joinWithSeparator("")
        let length = decimalString.characters.count
        let decimalStr = decimalString as NSString
        
        
        let hasLeadingOne = length > 0 && decimalStr.characterAtIndex(0) == (1 as unichar)
        
        if length == 0 || (length > 9 && !hasLeadingOne) || length > 10
        {
            let newLength = self.text!.characters.count + string.characters.count - range.length as Int
            
            return (newLength > 9) ? false : true
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if hasLeadingOne
        {
            formattedString.appendString("1 ")
            index += 1
        }
        if (length - index) > 3
        {
            let areaCode = decimalStr.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", areaCode)
            index += 3
        }
        if length > 3 && length - index > 2
        {
            let prefix = decimalStr.substringWithRange(NSMakeRange(index, 2))
            formattedString.appendFormat("%@-", prefix)
            index += 2
        }
        
        let remainder = decimalStr.substringFromIndex(index)
        formattedString.appendString(remainder)
        self.text = formattedString as String
        return false
    }
    
    func formatPhoneNumber(range: NSRange, string: String) -> Bool {
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "01234567890").invertedSet)?.last != nil {
            return false
        }
        let newRange = self.text!.startIndex.advancedBy(range.location)..<self.text!.startIndex.advancedBy(range.location + range.length)
        let newString = self.text!.stringByReplacingCharactersInRange(newRange, withString: string)
        
        let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        
        let decimalString : String = components.joinWithSeparator("")
        let length = decimalString.characters.count
        let decimalStr = decimalString as NSString
        
        
        let hasLeadingOne = length > 0 && decimalStr.characterAtIndex(0) == (1 as unichar)
        if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
        {
            let newLength = self.text!.characters.count + string.characters.count - range.length as Int
            return (newLength > 10) ? false : true
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if hasLeadingOne
        {
            formattedString.appendString("1 ")
            index += 1
        }
        if (length - index) > 3
        {
            let areaCode = decimalStr.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("(%@)", areaCode)
            index += 3
        }
        if length - index > 3
        {
            let prefix = decimalStr.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        
        let remainder = decimalStr.substringFromIndex(index)
        formattedString.appendString(remainder)
        self.text = formattedString as String
        return false
    }
    
    func formatZipCode(range: NSRange, string: String) -> Bool {
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "01234567890").invertedSet)?.last != nil {
            return false
        }
        let newRange = self.text!.startIndex.advancedBy(range.location)..<self.text!.startIndex.advancedBy(range.location + range.length)
        let newString = self.text!.stringByReplacingCharactersInRange(newRange, withString: string)
        if newString.characters.count > 5 {
            return false
        }
        return true
    }
    func formatAmount(range: NSRange, string: String) -> Bool {
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "01234567890").invertedSet)?.last != nil {
            return false
        }
        let newRange = self.text!.startIndex.advancedBy(range.location)..<self.text!.startIndex.advancedBy(range.location + range.length)
        let newString = self.text!.stringByReplacingCharactersInRange(newRange, withString: string).stringByReplacingOccurrencesOfString("$ ", withString: "").stringByReplacingOccurrencesOfString(",", withString: "")
        
        self.setAmountText(newString)
        return false
    }
    func setAmountText(text: String) {
        var amountText = ""
        for (idx, char) in text.characters.reverse().enumerate() {
            if idx % 3 == 0 && idx != 0 {
                amountText = "," + amountText
            }
            amountText = "\(char)" + amountText
        }
        if !amountText.hasPrefix("$ ") && amountText.characters.count > 0 {
            amountText = "$ " + amountText
            self.text = amountText
        } else {
            self.text = amountText
        }
    }
    
    func formatExt(range: NSRange, string: String) -> Bool {
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "01234567890").invertedSet)?.last != nil {
            return false
        }
        let newRange = self.text!.startIndex.advancedBy(range.location)..<self.text!.startIndex.advancedBy(range.location + range.length)
        let newString = self.text!.stringByReplacingCharactersInRange(newRange, withString: string)
        if newString.characters.count > 3 {
            return false
        }
        return true
    }
    
    func formatFamilyMembersCount(range: NSRange, string: String) -> Bool{
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "01234567890").invertedSet)?.last != nil {
            return false
        }
        let newRange = self.text!.startIndex.advancedBy(range.location)..<self.text!.startIndex.advancedBy(range.location + range.length)
        let newString = self.text!.stringByReplacingCharactersInRange(newRange, withString: string)
        if newString.characters.count > 2 {
            return false
        }
        return true
    }
    
    func formatMRNumber(range: NSRange, string: String) -> Bool{
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "01234567890").invertedSet)?.last != nil {
            return false
        }
        let newRange = self.text!.startIndex.advancedBy(range.location)..<self.text!.startIndex.advancedBy(range.location + range.length)
        let newString = self.text!.stringByReplacingCharactersInRange(newRange, withString: string)
        if newString.characters.count > 8 {
            return false
        }
        return true
    }

    func formatNumbers(range: NSRange, string: String, count : Int) -> Bool {
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "01234567890").invertedSet)?.last != nil {
            return false
        }
        let newRange = self.text!.startIndex.advancedBy(range.location)..<self.text!.startIndex.advancedBy(range.location + range.length)
        let newString = self.text!.stringByReplacingCharactersInRange(newRange, withString: string)
        if newString.characters.count > count {
            return false
        }
        return true
    }
    func formatToothNumbers(range: NSRange, string: String) -> Bool {
        if string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            return true
        }
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "01234567890,").invertedSet)?.last != nil {
            return false
        }
        
        let newRange = self.text!.startIndex.advancedBy(range.location)..<self.text!.startIndex.advancedBy(range.location + range.length)
        let textFieldString = self.text!.stringByReplacingCharactersInRange(newRange, withString: string)
        let textString = textFieldString.componentsSeparatedByString(",")
        
        if textFieldString.characters.count > 2 {
            let lastString = textFieldString.substringFromIndex(textFieldString.startIndex.advancedBy(textFieldString.characters.count - 1))
            let lastTwoStrings = textFieldString.substringFromIndex(textFieldString.startIndex.advancedBy(textFieldString.characters.count - 2))
            let lastThreeStrings = textFieldString.substringFromIndex(textFieldString.startIndex.advancedBy(textFieldString.characters.count - 3))
            
            if lastTwoStrings == ",," {
                return false
            }
            if lastString == "," && lastThreeStrings.componentsSeparatedByString(",").count == 3 {
                let requiredString = textFieldString.substringToIndex(textFieldString.startIndex.advancedBy(textFieldString.characters.count - 2)) + "0" + lastTwoStrings
                self.text = requiredString
                return false
            }
            
        } else {
            if textFieldString.characters.count == 2 {
                let lastString = textFieldString.substringFromIndex(textFieldString.startIndex.advancedBy(textFieldString.characters.count - 1))
                if lastString == "," {
                    self.text = "0" + textFieldString
                    return false
                }
            }
            if textFieldString == "," {
                return false
            }
        }
        for text in textString {
            if text == "0" {
                return true
            }
            if text == "00" {
                return false
            }
            if Int(text) > 35 {
                return false
            }
        }
        return true
    }
    
    func formatInitial(range: NSRange, string: String) -> Bool {
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_").invertedSet)?.last != nil {
            return false
        }
        let newRange = text!.startIndex.advancedBy(range.location)..<text!.startIndex.advancedBy(range.location + range.length)
        let newString = text!.stringByReplacingCharactersInRange(newRange, withString: string)
        if newString.characters.count > 1 {
            return false
        }
        return true
    }
    func formatName(range: NSRange, string: String) -> Bool {
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_ ").invertedSet)?.last != nil {
            return false
        }
        let newRange = text!.startIndex.advancedBy(range.location)..<text!.startIndex.advancedBy(range.location + range.length)
        let newString = text!.stringByReplacingCharactersInRange(newRange, withString: string)
        if newString.characters.count > 30 {
            return false
        }
        return true
    }
    func formatFullName(range: NSRange, string: String) -> Bool {
        if string.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_ ").invertedSet)?.last != nil {
            return false
        }
        let newRange = text!.startIndex.advancedBy(range.location)..<text!.startIndex.advancedBy(range.location + range.length)
        let newString = text!.stringByReplacingCharactersInRange(newRange, withString: string)
        if newString.characters.count > 63 {
            return false
        }
        return true
    }
}

extension UITextView {
    var isEmpty : Bool {
        return self.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
    }
}



extension String {
    
    var fileName : String {
        return self.stringByReplacingOccurrencesOfString(" - ", withString: "_").stringByReplacingOccurrencesOfString(" ", withString: "_").stringByReplacingOccurrencesOfString("/", withString: "_OR_")
    }
    
    public func rangeOfText(text : String) -> NSRange {
        return NSMakeRange(self.characters.count - text.characters.count, text.characters.count)
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
//    var isValidEmail : Bool {
//        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluateWithObject(self)
//    }
    
    var isValidEmail : Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    
    var isPhoneNumber: Bool {
        let charcter  = NSCharacterSet(charactersInString: "+0123456789").invertedSet
        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
        let filtered = inputString.componentsJoinedByString("")
        return filtered.characters.count == 10
    }
    
    var isZipCode: Bool {
        let charcter  = NSCharacterSet(charactersInString: "0123456789").invertedSet
        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
        let filtered = inputString.componentsJoinedByString("")
        return filtered.characters.count == 5
    }
    
    var isSocialSecurityNumber: Bool {
        let charcter  = NSCharacterSet(charactersInString: "0123456789").invertedSet
        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
        let filtered = inputString.componentsJoinedByString("")
        return filtered.characters.count == 9
    }
    
    var isValidExt: Bool {
        let charcter  = NSCharacterSet(charactersInString: "0123456789").invertedSet
        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
        let filtered = inputString.componentsJoinedByString("")
        return filtered.characters.count == 3
    }
    
    var is18YearsOld : Bool {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        let birthDate = dateFormatter.dateFromString(self.capitalizedString)
        let ageComponents = NSCalendar.currentCalendar().components(.Year, fromDate: birthDate!, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
        return ageComponents.year >= 18
    }
    
    func setTextForArrayOfLabels(arrayOfLabels: [UILabel]) {
        
        if arrayOfLabels.count == 0 {
            return
        }
        
        let wordArray = self.componentsSeparatedByString(" ")
        
        var textToCheck: NSString = ""
        
        for string in wordArray {
            
            let label = arrayOfLabels[0]
            textToCheck = textToCheck.length == 0 ? (textToCheck as String) + string : (textToCheck as String) + " " + string
            
            let size = textToCheck.sizeWithAttributes([NSFontAttributeName: label.font])
            //            let size = textToCheck.boundingRectWithSize(CGSizeMake(CGRectGetWidth(label.frame), 99999), options: NSStringDrawingOptions.UsesFontLeading, attributes: [NSFontAttributeName: label.font], context: nil)
            if size.height > CGRectGetHeight(label.frame) || size.width > CGRectGetWidth(label.frame) {
                var array = arrayOfLabels
                array.removeFirst()
                ((self as NSString).stringByReplacingCharactersInRange(NSMakeRange(0, textToCheck.length), withString: "")).setTextForArrayOfLabels(array)
                return
            } else {
                label.text = textToCheck as String
            }
        }
    }
  
}

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: [.UsesLineFragmentOrigin, .UsesFontLeading], context: nil)
        return ceil(boundingBox.height) + 10
    }

}

