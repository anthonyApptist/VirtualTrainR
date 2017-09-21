//
//  TestView.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-16.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class TestView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let profileHeader = ProfileTableHeaderView()
//        profileHeader.contentMode = .redraw
        self.view.addSubview(profileHeader)
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        profileHeader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileHeader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        profileHeader.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        profileHeader.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
//        profileHeader.setNeedsDisplay()
    }
}
