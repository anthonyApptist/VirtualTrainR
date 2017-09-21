//
//  VTNavigation.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-03.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class VTNavigation: UINavigationController {
    
    // View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: self.createFontWithSize(fontName: standardFont, size: 17.0)]
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationBar.barTintColor = kBarTintColor
    }
    
}
