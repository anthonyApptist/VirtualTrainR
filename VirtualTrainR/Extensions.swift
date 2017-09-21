//
//  Extensions.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-17.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

extension NSObject { // functions
    
    // MARK: - Resize UIImage to Target Size
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    // MARK: - Reset User Defaults
    func resetUserDefaults() {
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
    }
    
    // MARK: - Convenience Functions
    func dateStringConvert(date: String?) -> Date? { // facebook format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YYYY"
        // conversion
        if let birthdate = date {
            let date = dateFormatter.date(from: birthdate)
            return date
        }
        else {
            return nil
        }
    }
    
    func datePickerTextConvert(date: String?) -> Date? { // text format from datepicker
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        // conversion
        if let birthdate = date {
            let date = dateFormatter.date(from: birthdate)
            return date
        }
        else {
            return nil
        }
    }
    
    func dateFormatToString(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        // conversion
        if let birthdate = date {
            let dateString = dateFormatter.string(from: birthdate)
            return dateString
        }
        else {
            return ""
        }
    }
    
    // Picture URL to UIImage
    func urlStringToImage(urlString: String) -> UIImage {
        let url = URL(string: urlString)
        let pictureData = NSData(contentsOf: url!)
        let image = UIImage(data: pictureData! as Data)
        return image!
    }
    
    // Make Strings to One Line
    func appendName(_ first: String, last: String) -> String {
        let name = "\(first) \(last)"
        return name
    }
    
}

extension String {
    // check for blank string
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: NSCharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    // check if email is valid
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
}

extension UILabel {
    // set line height of label
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }
    // set custom spacing
    func setSpacing(space: CGFloat) {
        let attributedString = NSMutableAttributedString(string: (self.text)!)
        attributedString.addAttribute(NSKernAttributeName, value: space, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}

extension UIView {
    // create font
    func createFontWithSize(fontName: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: fontName, size: size)!
        return font
    }
    
    func makeRound() {
        let radius = self.frame.width/2
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

extension UIViewController {
    // activity indicators
    func showActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // create font
    func createFontWithSize(fontName: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: fontName, size: size)!
        return font
    }
    
    // create and present alert controller for VC
    func createAlertController(title: String, message: String?, actionTitle: String?, actionStyle: UIAlertActionStyle) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: actionStyle, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}
