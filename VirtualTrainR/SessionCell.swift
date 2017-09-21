//
//  SessionCell.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-20.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class SessionCell: UITableViewCell {
    
    // View Properties
    var titleLbl: UILabel!
    var nameTitle: UILabel!
    var nameLbl: UILabel!
    var timeTitle: UILabel!
    var timeLbl: UILabel!
    var dateTitle: UILabel!
    var dateLbl: UILabel!
    var locationTitle: UILabel!
    var locationLbl: UILabel!
    
    // accept and decline button
    var acceptBtn: UIButton!
    var declineBtn: UIButton!
    
    // cell session
    var cellSession: Session?
    
    // Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // title
        titleLbl = UILabel()
        titleLbl.font = UIFont(name: standardFont, size: 15)
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.textAlignment = .center
        titleLbl.textColor = UIColor.lightGray
        titleLbl.text = "1 Hour Session"
        self.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLbl.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // name title
        nameTitle = UILabel()
        nameTitle.font = UIFont(name: standardFont, size: 15)
        nameTitle.adjustsFontSizeToFitWidth = true
        nameTitle.textAlignment = .right
        nameTitle.textColor = UIColor.lightGray
        nameTitle.text = "With:"
        self.addSubview(nameTitle)
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        nameTitle.topAnchor.constraint(equalTo: titleLbl.bottomAnchor).isActive = true
        nameTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        nameTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // name label
        nameLbl = UILabel()
        nameLbl.font = UIFont(name: standardFont, size: 15)
        nameLbl.adjustsFontSizeToFitWidth = true
        nameLbl.textAlignment = .left
        nameLbl.textColor = UIColor.lightGray
        self.addSubview(nameLbl)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.leadingAnchor.constraint(equalTo: nameTitle.trailingAnchor, constant: 20).isActive = true
        nameLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor).isActive = true
        nameLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
        nameLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // time title
        timeTitle = UILabel()
        timeTitle.font = UIFont(name: standardFont, size: 15)
        timeTitle.adjustsFontSizeToFitWidth = true
        timeTitle.textAlignment = .right
        timeTitle.textColor = UIColor.lightGray
        timeTitle.text = "Start Time:"
        self.addSubview(timeTitle)
        timeTitle.translatesAutoresizingMaskIntoConstraints = false
        timeTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        timeTitle.topAnchor.constraint(equalTo: nameTitle.bottomAnchor).isActive = true
        timeTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        timeTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // time label
        timeLbl = UILabel()
        timeLbl.font = UIFont(name: standardFont, size: 15)
        timeLbl.adjustsFontSizeToFitWidth = true
        timeLbl.textAlignment = .left
        timeLbl.textColor = UIColor.lightGray
        self.addSubview(timeLbl)
        timeLbl.translatesAutoresizingMaskIntoConstraints = false
        timeLbl.leadingAnchor.constraint(equalTo: timeTitle.trailingAnchor, constant: 20).isActive = true
        timeLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor).isActive = true
        timeLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
        timeLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // date title
        dateTitle = UILabel()
        dateTitle.font = UIFont(name: standardFont, size: 15)
        dateTitle.adjustsFontSizeToFitWidth = true
        dateTitle.textAlignment = .right
        dateTitle.textColor = UIColor.lightGray
        dateTitle.text = "Date:"
        self.addSubview(dateTitle)
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
        dateTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        dateTitle.topAnchor.constraint(equalTo: timeTitle.bottomAnchor).isActive = true
        dateTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        dateTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // date label
        dateLbl = UILabel()
        dateLbl.font = UIFont(name: standardFont, size: 15)
        dateLbl.adjustsFontSizeToFitWidth = true
        dateLbl.textAlignment = .left
        dateLbl.textColor = UIColor.lightGray
        self.addSubview(dateLbl)
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.leadingAnchor.constraint(equalTo: dateTitle.trailingAnchor, constant: 20).isActive = true
        dateLbl.topAnchor.constraint(equalTo: timeLbl.bottomAnchor).isActive = true
        dateLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
        dateLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // location title
        locationTitle = UILabel()
        locationTitle.font = UIFont(name: standardFont, size: 15)
        locationTitle.adjustsFontSizeToFitWidth = true
        locationTitle.textAlignment = .right
        locationTitle.textColor = UIColor.lightGray
        locationTitle.text = "Location:"
        self.addSubview(locationTitle)
        locationTitle.translatesAutoresizingMaskIntoConstraints = false
        locationTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        locationTitle.topAnchor.constraint(equalTo: dateTitle.bottomAnchor).isActive = true
        locationTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        locationTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // location label
        locationLbl = UILabel()
        locationLbl.font = UIFont(name: standardFont, size: 15)
        locationLbl.adjustsFontSizeToFitWidth = true
        locationLbl.textAlignment = .left
        locationLbl.textColor = UIColor.lightGray
        self.addSubview(locationLbl)
        locationLbl.translatesAutoresizingMaskIntoConstraints = false
        locationLbl.leadingAnchor.constraint(equalTo: locationTitle.trailingAnchor, constant: 20).isActive = true
        locationLbl.topAnchor.constraint(equalTo: dateLbl.bottomAnchor).isActive = true
        locationLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
        locationLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // accept button
        acceptBtn = UIButton(type: .system)
        acceptBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        acceptBtn.setTitle("Accept", for: .normal)
        acceptBtn.setTitleColor(UIColor.green, for: .normal)
        acceptBtn.addTarget(self, action: #selector(self.acceptBtnPressed), for: .touchUpInside)
        self.addSubview(acceptBtn)
        acceptBtn.translatesAutoresizingMaskIntoConstraints = false
        acceptBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        acceptBtn.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5).isActive = true
        acceptBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        acceptBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
        // decline button
        declineBtn = UIButton(type: .system)
        declineBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        declineBtn.setTitle("Decline", for: .normal)
        declineBtn.setTitleColor(UIColor.red, for: .normal)
        declineBtn.addTarget(self, action: #selector(self.declineBtnPressed), for: .touchUpInside)
        self.addSubview(declineBtn)
        declineBtn.translatesAutoresizingMaskIntoConstraints = false
        declineBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        declineBtn.topAnchor.constraint(equalTo: acceptBtn.bottomAnchor, constant: 10).isActive = true
        declineBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        declineBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true
        
    }
    
    // MARK: - Accept Button Function
    func acceptBtnPressed() {
        // accepted session
        DataService.instance.saveTrainerAcceptedSession(cellSession!)
        
        // button adjustments
        acceptBtn.alpha = 0.2
        acceptBtn.isUserInteractionEnabled = false
        declineBtn.alpha = 0.2
        declineBtn.isUserInteractionEnabled = false
    }
    
    // MARK: - Decline Button Function
    func declineBtnPressed() {
        // declined session
        let sessionID = cellSession?.id
        DataService.instance.removeTrainerDeclinedSession(sessionID!)
        
        // button adjustments
        acceptBtn.alpha = 0.2
        acceptBtn.isUserInteractionEnabled = false
        declineBtn.alpha = 0.2
        declineBtn.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
