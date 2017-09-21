//
//  ProfileTableHeaderView.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-16.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    // title view
    var titleView: ProfileTitleView?
    
    // background
    var background: UIView?
    
    // Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.clipsToBounds = true
        
        // background view, to set colour
        background = UIView(frame: contentView.frame)
        background?.backgroundColor = UIColor.white
        self.backgroundView = background
        
        titleView = ProfileTitleView()
        titleView?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleView!)
        titleView?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleView?.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleView?.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        titleView?.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
