//
//  LogInVC.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-17.
//  Copyright © 2017 Apptist. All rights reserved.
//

import UIKit

// Log in screen for email and password

class LogInVC: RegisterVC {
    
    // MARK: - View Properties
    let emailTextField = VTTextField(type: 0)
    let passwordTextField = VTTextField(type: 1)
    
    let continueBtn = RoundVTButton(type: .system)
    let continueLbl = VTLabel()
    
    let subTitleLbl = VTLabel()

    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate
        AuthService.instance.authDelegate = self
        
        self.setTitleString(str: "Almost there!")
        
        // subtitle
        self.view.addSubview(subTitleLbl)
        subTitleLbl.text = "Log in to save your settings!"
        subTitleLbl.font = UIFont(name: subtitleFont, size: 15)
        subTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        subTitleLbl.centerXAnchor.constraint(equalTo: self.titleLbl.centerXAnchor, constant: 0).isActive = true
        subTitleLbl.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 0).isActive = true
        subTitleLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        subTitleLbl.heightAnchor.constraint(equalTo: self.titleLbl.heightAnchor, multiplier: 0.2).isActive = true
        
        // email textfields
        self.emailTextField.setup(placeholder: "Email", validator: "email", type: "email")
        self.passwordTextField.setup(placeholder: "Password", validator: "required", type: "password")

        emailTextField.font = UIFont(name: standardFont, size: 15)
        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: self.titleLbl.centerXAnchor, constant: 10).isActive = true
        emailTextField.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 30).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // password textfield
        passwordTextField.font = UIFont(name: standardFont, size: 15)
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: self.emailTextField.centerXAnchor, constant: 0).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // continue button
        self.view.addSubview(continueBtn)
        continueBtn.alpha = 0.2
        continueBtn.translatesAutoresizingMaskIntoConstraints = false
        continueBtn.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor, constant: 0).isActive = true
        continueBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        continueBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        continueBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        continueBtn.addTarget(self, action: #selector(continueBtnPressed), for: .touchUpInside)
        
        // label for continue button
        self.view.addSubview(continueLbl)
        continueLbl.font = UIFont(name: standardFont, size: 15)
        continueLbl.text = "Continue"
        continueLbl.textAlignment = .center
        continueLbl.textColor = UIColor.white
        continueLbl.translatesAutoresizingMaskIntoConstraints = false
        continueLbl.centerXAnchor.constraint(equalTo: continueBtn.centerXAnchor).isActive = true
        continueLbl.centerYAnchor.constraint(equalTo: continueBtn.centerYAnchor).isActive = true
        continueLbl.widthAnchor.constraint(equalTo: continueBtn.widthAnchor).isActive = true
        continueLbl.heightAnchor.constraint(equalTo: continueBtn.heightAnchor).isActive = true
        
        
    }
    
    // MARK: - Continue Btn Function
    func continueBtnPressed() {
        _ = validate(showError: true)
        
        if(!validate(showError: true)) {
            return
        }
        else {
            let email = emailTextField.text
            let password = passwordTextField.text
            
            if AuthService.instance.checkUserExists() {
                AuthService.instance.login(email: email!, password: password!, info: nil)
            }
            else {
                let authProfile = AuthProfile(type: AuthType.email)
                authProfile.email = email
                authProfile.password = password
                let basicInfoVC = BasicInfoVC(profile: authProfile)
                self.present(basicInfoVC, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Validation
    func validate(showError: Bool) -> Bool {
        ErrorHandler.sharedInstance.errorMessageView.resetImagePosition()
        if(!emailTextField.validate()) {
            if(showError) {
                if(emailTextField.validationError == "blank") {
                    ErrorHandler.sharedInstance.show(message: "Email Field Cannot Be Blank", container: self)
                }
                if(emailTextField.validationError == "not_email") {
                    ErrorHandler.sharedInstance.show(message: "You should double-check that email address....", container: self)
                }
            }
            return false
        }
        
        if(!passwordTextField.validate()) {
            if(showError) {
                if(passwordTextField.validationError == "blank") {
                    ErrorHandler.sharedInstance.show(message: "Password Field Cannot Be Blank", container: self)
                }
            }
            return false
        }
        return true
    }
    
    // MARK: - UITextfield Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if(!(emailTextField.text?.isBlank)!) {
            ErrorHandler.sharedInstance.errorMessageView.resetImagePosition()
        }
        
        if(!(passwordTextField.text?.isBlank)!) {
            ErrorHandler.sharedInstance.errorMessageView.resetImagePosition()
        }
    }
}

// MARK: - Authenticate Status
extension LogInVC: AuthenticateStatus {
    func errorLoggingIn(error: Error) {
        self.hideActivityIndicator()
        self.createAlertController(title: error.localizedDescription, message: "Try again", actionTitle: "OK", actionStyle: .cancel)
        self.continueBtn.isUserInteractionEnabled = true
    }
    
    func didStartLogin() {
        self.continueBtn.isUserInteractionEnabled = false
    }
    
    func didCompleteLogin() {
        self.hideActivityIndicator()
        let vtDashboard = VTDashboard(initialAccount: Portals.client)
        let dashboard = Dashboard(vtDashboard: vtDashboard)
        self.present(dashboard, animated: true, completion: nil)
    }
}
