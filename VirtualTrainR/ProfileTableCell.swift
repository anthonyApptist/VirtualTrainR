//
//  ProfileTableCell.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-04.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class ProfileTableCell: UITableViewCell {
    
    // cell properties
    var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        // label for cell
        titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
