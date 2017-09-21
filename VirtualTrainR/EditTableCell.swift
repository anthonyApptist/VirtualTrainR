//
//  EditTableCell.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-04.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class EditTableCell: UITableViewCell, UITextViewDelegate {
    
    // bio text view
    var bioLbl = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        // bio label
        bioLbl.adjustsFontSizeToFitWidth = true
        bioLbl.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        bioLbl.textAlignment = .left
        bioLbl.textColor = UIColor.black
        bioLbl.numberOfLines = 0
        bioLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.contentView.addSubview(bioLbl)
        bioLbl.translatesAutoresizingMaskIntoConstraints = false
        bioLbl.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        bioLbl.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        bioLbl.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        bioLbl.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
