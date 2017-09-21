//
//  BasicInfoVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-20.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class BasicInfoVC: RegisterVC {
    
    // View Properties
    var firstNameTextField = VTTextField(type: 2)
    var lastNameTextField = VTTextField(type: 3)
    var genderTextField = VTTextField(type: 4)
    var birthdayTextField = VTTextField(type: 5)
    var continueBtn = RoundVTButton()
    
    // datepicker
    var datePicker: UIDatePicker!
    
    // account profile data
    var authProfile: AuthProfile?
    
    // model
    var basicInfo: BasicInfo?
    
    // MARK: - Init with AuthProfile
    init(profile: AuthProfile) {
        super.init(nibName: nil, bundle: nil)
        
        authProfile = profile
        authProfile?.profileDelegate = self
        authProfile?.signInProgress = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title label from super class
        self.titleLbl.text = "Personal Info"
        
        // first name textfield
        firstNameTextField.delegate = self
        firstNameTextField.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        self.view.addSubview(firstNameTextField)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        firstNameTextField.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 0).isActive = true
        firstNameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        firstNameTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // last name textfield
        lastNameTextField.delegate = self
        lastNameTextField.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        self.view.addSubview(lastNameTextField)
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        lastNameTextField.topAnchor.constraint(equalTo: self.firstNameTextField.bottomAnchor, constant: 5).isActive = true
        lastNameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        lastNameTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // gender textfield
        genderTextField.delegate = self
        genderTextField.autocorrectionType = .no
        genderTextField.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        self.view.addSubview(genderTextField)
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        genderTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        genderTextField.topAnchor.constraint(equalTo: self.lastNameTextField.bottomAnchor, constant: 5).isActive = true
        genderTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        genderTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // birthdate textfield
        birthdayTextField.delegate = self
        birthdayTextField.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        self.view.addSubview(birthdayTextField)
        birthdayTextField.translatesAutoresizingMaskIntoConstraints = false
        birthdayTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        birthdayTextField.topAnchor.constraint(equalTo: self.genderTextField.bottomAnchor, constant: 5).isActive = true
        birthdayTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        birthdayTextField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // continue button
        continueBtn.setTitle("Continue", for: .normal)
        continueBtn.titleLabel?.textColor = UIColor.white
        continueBtn.addTarget(self, action: #selector(self.continueBtnFunction), for: .touchUpInside)
        self.view.addSubview(continueBtn)
        continueBtn.translatesAutoresizingMaskIntoConstraints = false
        continueBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        continueBtn.topAnchor.constraint(equalTo: self.birthdayTextField.bottomAnchor, constant: 20).isActive = true
        continueBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        continueBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // datepicker 
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
        datePicker.isHidden = true
        self.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: self.birthdayTextField.bottomAnchor, constant: 10).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // get info
        self.authProfile?.getProfileInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        AuthService.instance.authDelegate = self.authProfile
    }
    
    // MARK: - UITextfield Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case birthdayTextField:
            datePicker.isHidden = false
            birthdayTextField.resignFirstResponder()
            break
        default:
            break
        }
    }
    
    // MARK: - DatePicker
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        birthdayTextField.text = formatter.string(from: sender.date)
//        print(birthdayTextField.text)
    }
    
    // MARK: - ContinueBtn Function
    func continueBtnFunction() {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
            self.createAlertController(title: "First name is empty", message: nil, actionTitle: "OK", actionStyle: .cancel)
            return
        }
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
            self.createAlertController(title: "Last name is empty", message: nil, actionTitle: "OK", actionStyle: .cancel)
            return
        }
        
        var gender: String? = nil
        var birthdate: String? = nil
        
        if !((genderTextField.text?.isEmpty)!) {
//            self.createAlertController(title: "Gender is empty", message: nil, actionTitle: "OK", actionStyle: .cancel)
            gender = genderTextField.text
        }
        if !((birthdayTextField.text?.isEmpty)!) {
//            self.createAlertController(title: "Birthday is empty", message: nil, actionTitle: "OK", actionStyle: .cancel)
            birthdate = birthdayTextField.text
        }
        
        self.basicInfo?.firstName = firstName
        self.basicInfo?.lastname = lastName
        self.basicInfo?.gender = gender
        self.basicInfo?.birthdate = birthdate
        
        // sign in account
        self.authProfile?.signInNewUser(_withBasicInfo: self.basicInfo!)
    }
    
    // MARK: - Update UI
    func update() {
        self.firstNameTextField.text = self.basicInfo?.firstName
        self.lastNameTextField.text = self.basicInfo?.lastname
        self.genderTextField.text = self.basicInfo?.gender
        self.birthdayTextField.text = self.basicInfo?.birthdate
    }
    
    // MARK: - Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        genderTextField.resignFirstResponder()
        birthdayTextField.resignFirstResponder()
        datePicker.isHidden = true
    }
    
}

extension BasicInfoVC: ProfileData, SignInProgress {
    // MARK: - ProfileData Delegate
    func errorGettingInfo(error: Error) {
        self.createAlertController(title: "Error retrieving Facebook info", message: error.localizedDescription, actionTitle: "OK", actionStyle: .cancel)
    }
    
    func updateEmailLogin(basicInfo: BasicInfo) {
        self.basicInfo = basicInfo
        self.update()
    }
    
    func updateFacebookLogin(basicInfo: BasicInfo) {
        self.basicInfo = basicInfo
        self.update()
    }
    
    // MARK: - Sign In Progress
    func displayError(error: Error) {
        self.createAlertController(title: "Error Logging In", message: "Try again", actionTitle: "OK", actionStyle: .cancel)
    }
    
    func displayActivityView() {
        self.showActivityView(.whiteLarge)
    }
    
    func removeActivityView() {
        self.hideActivityView()
        // go to dashboard
        let vtDashboard = VTDashboard(initialAccount: Portals.client)
        let dashboard = Dashboard(vtDashboard: vtDashboard)
        self.present(dashboard, animated: true, completion: nil)
    }
}
