//
//  RegisterVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-15.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class RegisterVC: VCAssets, UITextFieldDelegate {
    
    // View
    var vtlogo = UIImageView()
    var backgroundImgView = UIImageView()
    var titleLbl = VTLabel()
    var backBtn = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // background view (purple fade image)
        backgroundImgView = UIImageView()
        backgroundImgView.image = backgroundImage
        self.view.addSubview(backgroundImgView)
        backgroundImgView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        backgroundImgView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        backgroundImgView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        backgroundImgView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        // vt logo at top of screen
        vtlogo = UIImageView()
        vtlogo.image = vtImage
        vtlogo.contentMode = .scaleAspectFit
        self.view.addSubview(vtlogo)
        vtlogo.translatesAutoresizingMaskIntoConstraints = false
        vtlogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        vtlogo.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        vtlogo.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.09).isActive = true
        vtlogo.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.09).isActive = true
        
        // back button
        backBtn.frame = CGRect()
        backBtn.setImage(backBtnImage, for: .normal)
        backBtn.tintColor = UIColor.white
        backBtn.addTarget(self, action: #selector(self.backBtnPressed), for: .touchUpInside)
        self.view.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        backBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        backBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        backBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // title label to describe current question asking user
        titleLbl = VTLabel()
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont(name: thinFont, size: 30)
        self.view.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: self.vtlogo.bottomAnchor, constant: 20).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: self.vtlogo.centerXAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: self.vtlogo.bottomAnchor).isActive = true
        titleLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        titleLbl.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        
    }
    
    // set title of register screen
    func setTitleString(str: String) {
        titleLbl.text = str
    }
    
    // back button to dismiss current VC
    func backBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
