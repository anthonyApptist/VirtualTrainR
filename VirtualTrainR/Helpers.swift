//
//  Helpers.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-20.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

func heightOfLabel(_ withString: String, ofSize: CGFloat, inWidth: CGFloat) -> CGFloat {
    //let labelFont = UIFont.systemFontOfSize(ofSize)
    let labelFont = UIFont(name: "HelveticaNeue-Light", size: ofSize)!
    let labelSize = (withString as NSString).boundingRect(with: CGSize(width: inWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: labelFont], context: nil)
    return ceil(labelSize.height)
}
