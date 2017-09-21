//
//  LabelCustomSpacing.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-17.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class LabelCustomSpacing: UILabel {
    
    // MARK: - Create label
    
    var space: CGFloat = 1.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setSpacing(space: space)
    }
    
}
