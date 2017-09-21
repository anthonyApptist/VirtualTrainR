//
//  ChooseTimeVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-20.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

// Present this view to select a start time and date with chosen trainer

class ChooseTimeVC: VCAssets, UITextFieldDelegate {
    
    // view properties
    var cancelBtn: UIButton?
    var titleLbl: UILabel?
    var nextBtn: UIButton?
    var dateTextfield: UITextField?
    var timeTextfield: UITextField?
    var picker: UIDatePicker?
    
    // trainer
    var selectedTrainer: Trainer?
    var dateScheduled: String?
    var startTime: String?
    
    // dates with appointments
    var trainerAppointments: [String]?
    
    // created session delegate
    var created: CreatedSession?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // cancel btn
        cancelBtn = UIButton(type: .system)
        cancelBtn?.addTarget(self, action: #selector(cancelBtnFunction), for: .touchUpInside)
        cancelBtn?.contentMode = .scaleAspectFit
        cancelBtn?.setTitle("X", for: .normal)
        cancelBtn?.setTitleColor(UIColor.gray, for: .normal)
        self.view.addSubview(cancelBtn!)
        cancelBtn?.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        cancelBtn?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        cancelBtn?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        cancelBtn?.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        
        // next button
        nextBtn = UIButton(type: .system)
        nextBtn?.addTarget(self, action: #selector(nextBtnFunction), for: .touchUpInside)
        nextBtn?.contentMode = .scaleAspectFit
        nextBtn?.setTitle(">", for: .normal)
        nextBtn?.setTitleColor(UIColor.gray, for: .normal)
        self.view.addSubview(nextBtn!)
        nextBtn?.translatesAutoresizingMaskIntoConstraints = false
        nextBtn?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        nextBtn?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        nextBtn?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        nextBtn?.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        
        // title label
        titleLbl = UILabel()
        titleLbl?.text = "For a 1 hour session"
        titleLbl?.font = self.createFontWithSize(fontName: standardFont, size: 17.0)
        titleLbl?.textColor = UIColor.lightGray
        titleLbl?.adjustsFontSizeToFitWidth = true
        titleLbl?.textAlignment = .center
        self.view.addSubview(titleLbl!)
        titleLbl?.translatesAutoresizingMaskIntoConstraints = false
        titleLbl?.leadingAnchor.constraint(equalTo: cancelBtn!.trailingAnchor, constant: 20).isActive = true
        titleLbl?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        titleLbl?.trailingAnchor.constraint(equalTo: nextBtn!.leadingAnchor, constant: -20).isActive = true
        titleLbl?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.10).isActive = true
        
        // date textfield
        dateTextfield = UITextField()
        dateTextfield?.placeholder = "Select date"
        dateTextfield?.textAlignment = .center
        dateTextfield?.delegate = self
        dateTextfield?.font = self.createFontWithSize(fontName: standardFont, size: 17.0)
        dateTextfield?.textColor = UIColor.gray
        self.view.addSubview(dateTextfield!)
        dateTextfield?.translatesAutoresizingMaskIntoConstraints = false
        dateTextfield?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dateTextfield?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -self.view.frame.height/4).isActive = true
        dateTextfield?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        dateTextfield?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.10).isActive = true
        
        // date textfield
        timeTextfield = UITextField()
        timeTextfield?.placeholder = "Select start time"
        timeTextfield?.textAlignment = .center
        timeTextfield?.delegate = self
        timeTextfield?.font = self.createFontWithSize(fontName: standardFont, size: 17.0)
        timeTextfield?.textColor = UIColor.gray
        self.view.addSubview(timeTextfield!)
        timeTextfield?.translatesAutoresizingMaskIntoConstraints = false
        timeTextfield?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        timeTextfield?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        timeTextfield?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        timeTextfield?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.10).isActive = true
        
        // time picker
        picker = UIDatePicker()
        picker?.datePickerMode = .date
        picker?.addTarget(self, action: #selector(self.datePickerChanged(sender:)), for: .valueChanged)
        self.view.addSubview(picker!)
        picker?.translatesAutoresizingMaskIntoConstraints = false
        picker?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        picker?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        picker?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        picker?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.40).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        cancelBtn?.makeRound()
        cancelBtn?.layer.borderWidth = 1.0
        cancelBtn?.layer.borderColor = UIColor.gray.cgColor
        
        nextBtn?.makeRound()
        nextBtn?.layer.borderWidth = 1.0
        nextBtn?.layer.borderColor = UIColor.gray.cgColor
    }
    
    // MARK: - Cancel Btn Function
    func cancelBtnFunction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Next Btn Function
    func nextBtnFunction() {
        // save to database
        
        // create session (1 hour)
        let session = Session()
        
        session.date = dateTextfield?.text
        session.startTime = timeTextfield?.text
        session.trainerName = self.appendName((self.selectedTrainer?.basicInfo?.firstName)!, last: (self.selectedTrainer?.basicInfo?.lastname)!)
        session.trainerID = self.selectedTrainer?.accountID
        print(session.trainerName)
        print(session.trainerID)
        
        self.dismiss(animated: true, completion: {
            self.created?.presentMeetupLocation(session: session)
        })
    }
    
    // MARK: - Date Picker Changes
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        switch (sender.datePickerMode) {
        case .date:
            formatter.dateFormat = "MMMM dd, yyyy"
            let dateString = formatter.string(from: sender.date)
            dateTextfield?.text = dateString
            break
        case .time:
            formatter.dateFormat = "h:mm a"
            let timeString = formatter.string(from: sender.date)
            let startTime = "\(timeString)"
            timeTextfield?.text = startTime
            break
        default:
            break
        }
    }
    
    // MARK: - Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dateTextfield?.resignFirstResponder()
        timeTextfield?.resignFirstResponder()
    }
    
    // MARK: - Textfield Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(dateTextfield) {
            textField.resignFirstResponder()
            self.picker?.datePickerMode = .date
        }
        if textField.isEqual(timeTextfield) {
            textField.resignFirstResponder()
            self.picker?.datePickerMode = .time
        }
    }
}
