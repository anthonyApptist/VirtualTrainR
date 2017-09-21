//
//  QuestionButtonVC.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-15.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin

/*
 * View with two buttons as choices for a question
 */

var initial = ["How can Virtual TrainR assist you?",
                         "What gender do you identify with?"]

class QuestionsButtonVC: RegisterVC {
    
    // View Properties
    let topQuestionBtn = RoundVTButton()
    let bottomQuestionBtn = RoundVTButton()
    
    let topQuestionLbl = VTLabel()
    let bottomQuestionLbl = VTLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // top button selection
        topQuestionBtn.addTarget(self, action: #selector(topBtnNextPressed), for: .touchUpInside)
        self.view.addSubview(topQuestionBtn)
        topQuestionBtn.translatesAutoresizingMaskIntoConstraints = false
        topQuestionBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topQuestionBtn.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20).isActive = true
        topQuestionBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        topQuestionBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // top button label
        self.view.addSubview(topQuestionLbl)
        topQuestionLbl.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        topQuestionLbl.textColor = UIColor.white
        topQuestionLbl.translatesAutoresizingMaskIntoConstraints = false
        topQuestionLbl.centerXAnchor.constraint(equalTo: topQuestionBtn.centerXAnchor).isActive = true
        topQuestionLbl.centerYAnchor.constraint(equalTo: topQuestionBtn.centerYAnchor).isActive = true
        topQuestionLbl.widthAnchor.constraint(equalTo: topQuestionBtn.widthAnchor).isActive = true
        topQuestionLbl.heightAnchor.constraint(equalTo: topQuestionBtn.heightAnchor).isActive = true
        
        // bottom button selection
        bottomQuestionBtn.addTarget(self, action: #selector(bottomBtnNextPressed), for: .touchUpInside)
        self.view.addSubview(bottomQuestionBtn)
        bottomQuestionBtn.translatesAutoresizingMaskIntoConstraints = false
        bottomQuestionBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bottomQuestionBtn.topAnchor.constraint(equalTo: topQuestionBtn.bottomAnchor, constant: 15).isActive = true
        bottomQuestionBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        bottomQuestionBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // bottom button label
        bottomQuestionLbl.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        bottomQuestionLbl.textColor = UIColor.white
        self.view.addSubview(bottomQuestionLbl)
        bottomQuestionLbl.translatesAutoresizingMaskIntoConstraints = false
        bottomQuestionLbl.centerXAnchor.constraint(equalTo: bottomQuestionBtn.centerXAnchor).isActive = true
        bottomQuestionLbl.centerYAnchor.constraint(equalTo: bottomQuestionBtn.centerYAnchor).isActive = true
        bottomQuestionLbl.widthAnchor.constraint(equalTo: bottomQuestionBtn.widthAnchor).isActive = true
        bottomQuestionLbl.heightAnchor.constraint(equalTo: bottomQuestionBtn.heightAnchor).isActive = true
        
    }
    
    // MARK: - Set Button Titles
    // set top btn
    func setTopTitle(str: String) {
        topQuestionLbl.text = str
    }
    
    // set bottom btn
    func setBottomTitle(str: String) {
        bottomQuestionLbl.text = str
    }
    
    // MARK: - Top Btn Function
    func topBtnNextPressed() {
    
    }
    
    // MARK: - Bottom Btn Function
    func bottomBtnNextPressed() {
        
    }
    
}
