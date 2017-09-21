//
//  ClientCell.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-08.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class ClientCell: UITableViewCell {
    
    // View Properties
    var clientImageView = UIImageView()
    var nameLbl = UILabel()
    var locationLbl = UILabel()
    var bookBtn = UIButton(type: .system)
    
    // client
    var cellClient: Client?
    
    // Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // image view of client
        clientImageView.layer.cornerRadius = (contentView.frame.width * 0.2)/2
        clientImageView.layer.masksToBounds = true  
        clientImageView.clipsToBounds = true
        clientImageView.contentMode = .scaleAspectFit
        contentView.addSubview(clientImageView)
        clientImageView.translatesAutoresizingMaskIntoConstraints = false
        clientImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        clientImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        clientImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        clientImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        
        // name label
        nameLbl.font = UIFont(name: standardFont, size: 14)
        nameLbl.textAlignment = .left
        nameLbl.textColor = UIColor.black
        self.addSubview(nameLbl)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.leadingAnchor.constraint(equalTo: clientImageView.trailingAnchor, constant: 25).isActive = true
        nameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        nameLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        nameLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        
        // location label
        locationLbl.font = UIFont(name: standardFont, size: 14)
        locationLbl.adjustsFontSizeToFitWidth = true
        locationLbl.textAlignment = .left
        locationLbl.textColor = UIColor.lightGray
        self.addSubview(locationLbl)
        locationLbl.translatesAutoresizingMaskIntoConstraints = false
        locationLbl.topAnchor.constraint(equalTo: self.nameLbl.bottomAnchor).isActive = true
        locationLbl.leadingAnchor.constraint(equalTo: clientImageView.trailingAnchor, constant: 25).isActive = true
        locationLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        locationLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
