//
//  FirebaseCloud.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-30.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation

class FirebaseCloud {
    
    // public instance
    private static let _instance = FirebaseCloud()
    
    static var instance: FirebaseCloud {
        return _instance
    }
}
