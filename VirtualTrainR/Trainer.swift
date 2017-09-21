//
//  Trainer.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-14.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import CoreLocation

class Trainer : User {
    
    var currentLocation: CLLocationCoordinate2D?
    var fullName: String?
    var accountID: String?
    var certification: String?
    
    /*
    public var credentials : String?
    public var certifications : Array<Certification>
    public var verified : Bool
    public var clientHearted : Array<Client>
    public var offeredSessions : Array<Session>
    public var currentSessions : Array<InstanceSession>
//    public var offeredActivities : Array<Activity>
    public var clients : Array<Client>
    
    override init() {
        self.certifications = []
        self.verified = false
        self.clientHearted = []
        self.offeredSessions = []
        self.currentSessions = []
//        self.offeredActivities = []
        self.clients = []
        super.init()
        
    }
    */
}
