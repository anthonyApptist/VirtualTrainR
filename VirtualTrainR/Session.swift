//
//  Session.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-14.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation

class Session { // 1 hour session only
    
    // Properties
    var id: String? // unique for session
    var startTime: String?
    var date: String?
    var location: String?
    
    var clientName: String?
    var clientID: String?
    var trainerName: String?
    var trainerID: String?
    
    // optional
    var accepted: Bool?
    var paid: Bool?
    
    // Init
    init() {
        self.id = nil
        self.startTime = nil
        self.date = nil
        self.location = nil
        self.clientName = nil
        self.clientID = nil
        self.trainerName = nil
        self.trainerID = nil
        self.accepted = nil
    }
}
