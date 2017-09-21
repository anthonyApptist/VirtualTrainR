//
//  EditProfileVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-04.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

protocol ChangeProfileInfo {
    func didChangeBio(_ text: String)
    func didChangeLocation(_ text: String)
    func didChangeCertification(_ text: String)
}

class EditProfileVC: VCAssets, UITextViewDelegate {
    
    // title 
    let viewTitle = UILabel()
    
    // text view to edit
    let textView = UITextView()
    
    // dismiss button
    let closeBtn = UIButton(type: .system)
    
    // save button
    let saveBtn = UIButton(type: .system)
    
    // initial text
    var initialText: String?
    
    // editing title
    var editTitle: EditingViewTitle?
    
    // delegate
    var changeDelegate: ChangeProfileInfo?
    
    // current user type
    var userType: UserType?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // title label
        viewTitle.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        viewTitle.textColor = UIColor.black
        viewTitle.adjustsFontSizeToFitWidth = true
        viewTitle.textAlignment = .center
        self.view.addSubview(viewTitle)
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewTitle.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        viewTitle.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        viewTitle.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        closeBtn.setImage(#imageLiteral(resourceName: "cancel_button.png"), for: .normal) // cancel_button.png
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        self.view.addSubview(closeBtn)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        closeBtn.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 5).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        textView.delegate = self
        textView.backgroundColor = UIColor.white
        textView.sizeToFit()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        self.view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 20).isActive = true
        textView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        textView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        
        saveBtn.titleLabel?.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        saveBtn.backgroundColor = UIColor.gray
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.layer.cornerRadius = 10
        saveBtn.setTitleColor(UIColor.white, for: .normal)
        saveBtn.addTarget(self, action: #selector(saveBtnPressed), for: .touchUpInside)
        self.view.addSubview(saveBtn)
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        saveBtn.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20).isActive = true
        saveBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        saveBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // set title
        viewTitle.text = self.editTitle?.rawValue
    }
    
    // MARK: - Close Btn Pressed
    func closeBtnPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    // Save Btn Pressed
    func saveBtnPressed() {
        // if same text or no text
        if textView.text.isBlank || textView.text == initialText {
            return
        }
        // save to database and update in profile
        switch self.editTitle! {
        case .bio:
            self.changeDelegate?.didChangeBio(textView.text)
            DataService.instance.saveEditableInfo(forInfoType: .bio, text: textView.text, account: self.userType!)
            break
        case .location:
            self.changeDelegate?.didChangeLocation(textView.text)
            DataService.instance.saveEditableInfo(forInfoType: .location, text: textView.text, account: self.userType!)
            break
        case .certification:
            self.changeDelegate?.didChangeCertification(textView.text)
            DataService.instance.saveEditableInfo(forInfoType: .certification, text: textView.text, account: self.userType!)
            break
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Text View Delegate
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
}
