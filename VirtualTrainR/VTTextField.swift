//
//  VTTextField.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-17.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class VTTextField: UITextField {
    
    // View
    let underView = UIView()
    let viewIcon = UIImageView()
    var textFieldType: Int!
    var fieldLabel: UILabel!
    var validator: String!
    var validationError: String!
    var selectedPlaceholder: String!

    // MARK: - Type of Textfield
    init(type: Int) {
        self.init()
        
        textFieldType = type
        
        switch textFieldType {
        case 0:
            self.placeholder = "Enter Email"
            self.isSecureTextEntry = false
            viewIcon.image = #imageLiteral(resourceName: "mail_ic.png") // mail_ic.png
        case 1:
            self.placeholder = "Enter Password"
            self.isSecureTextEntry = true
            viewIcon.image = #imageLiteral(resourceName: "password_ic.png") // password_ic.png
        case 2:
            self.placeholder = "First Name"
            viewIcon.image = #imageLiteral(resourceName: "vt_icon.png") // vt_icon.png
        case 3:
            self.placeholder = "Last Name"
            viewIcon.image = #imageLiteral(resourceName: "vt_icon.png") // vt_icon.png
        case 4:
            self.placeholder = "Gender"
            viewIcon.image = #imageLiteral(resourceName: "vt_icon.png") // vt_icon.png
        case 5:
            self.placeholder = "Enter Birthdate"
            viewIcon.image = #imageLiteral(resourceName: "birthday_ic.png") // birthday_ic.png
        default:
            break
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.white
        
        // underline
        self.addSubview(underView)
        underView.backgroundColor = UIColor.white
        underView.translatesAutoresizingMaskIntoConstraints = false
        underView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        underView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        underView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        underView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.01).isActive = true
        
        
        // icon image
        self.addSubview(viewIcon)
        viewIcon.contentMode = .scaleAspectFit
        viewIcon.translatesAutoresizingMaskIntoConstraints = false
        viewIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -40).isActive = true
        viewIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewIcon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        viewIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(placeholder: String!, validator: String!, type: String!){
        
        // set placeholder for email or password
        self.placeholder = placeholder
        self.selectedPlaceholder = placeholder.uppercased()
        self.validator = validator
        
        if(type == "email") {
            self.keyboardType = .emailAddress
            self.autocapitalizationType = .none
            self.spellCheckingType = .no
            self.autocorrectionType = .no
            
        } else if (type == "password") {
            self.keyboardType = .default
            self.isSecureTextEntry = true
            self.spellCheckingType = .no
            self.autocapitalizationType = .none
            self.autocorrectionType = .no
            
        } else {
            self.keyboardType = .default
            self.spellCheckingType = .no
        }
        
        
    }
    
    
    // MARK: - Validation Textfield
    func validate() -> Bool {
        
        self.validationError = "";
        
        if(self.validator == "optional") {
            return true
        }
        
        if(self.validator == "required") {
            if(self.text?.isBlank)! {
                self.validationError = "blank"
                return false
            }
        }
        
        if(self.validator == "email") {
            if(self.text?.isBlank)! {
                self.validationError = "blank"
                return false
            }
            
            if(!(self.text?.isEmail)!) {
                self.validationError = "not_email"
                return false
            }
        }
        return true
        
    }

    
    
}
