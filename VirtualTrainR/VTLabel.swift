//
//  VTLabel.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-15.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class VTLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.lineBreakMode = .byTruncatingMiddle
        self.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


