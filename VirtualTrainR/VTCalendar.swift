//
//  VTCalendar.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-02.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FirebaseDatabase

// Update calendarVC protocol
protocol CalendarUpdate {
    func updateSessionList(session: [Session])
}

class VTCalendar: NSObject {
    
    // portal
    var portal: Portals?
    
    // calendar update
    var calendarDelegate: CalendarUpdate?
    
    // database reference
    var sessionsRef: DatabaseReference?
    
    // model
    var sessions: [Session]?
    
    // Init
    init(portal: Portals) {
        super.init()
        
        self.portal = portal
    }
    
    // get info based on portal
    func getCalendarInfo() {
        switch self.portal! {
        case .client:
            self.getClientCalendar()
            break
        case .trainer:
            self.getTrainerCalendar()
            break
        }
    }
    
    // MARK: - Get Client Calandar
    func getClientCalendar() {
        
        let clientID = UserDefaults.standard.value(forKey: "clientID") as! String
        self.sessionsRef = DataService.instance.clientRef.child(clientID).child("sessions")
        
        self.sessionsRef?.observe(.value, with: { (snapshot) in
            self.sessions = []
            for child in snapshot.children.allObjects {
                let session = child as! DataSnapshot
                let sessionData = session.value as? NSDictionary
                
                // Session
                let aSession = Session()
                
                // unique session id
                let sessionID = session.key
                aSession.id = sessionID
                
                // trainer
                let trainerName = sessionData?["trainer"] as! String
                aSession.trainerName = trainerName
                
                // session details
                let startTime = sessionData?["startTime"] as! String
                let date = sessionData?["date"] as! String
                let location = sessionData?["location"] as! String
                
                aSession.startTime = startTime
                aSession.date = date
                aSession.location = location
                
                self.sessions?.append(aSession)
            }
            self.calendarDelegate?.updateSessionList(session: self.sessions!.reversed())
            
        }, withCancel: { (error) in
            // handle error
        })
    }
    
    // MARK: - Get Trainer Calandar
    func getTrainerCalendar() {
        let trainerID = UserDefaults.standard.value(forKey: "trainerID") as! String
        self.sessionsRef = DataService.instance.trainerRef.child(trainerID).child("sessions")
        
        self.sessionsRef?.observe(.value, with: { (snapshot) in
            self.sessions = []
            for child in snapshot.children.allObjects {
                let session = child as! DataSnapshot
                let sessionData = session.value as? NSDictionary
                
                let aSession = Session()
                aSession.accepted = false
                
                let sessionID = session.key
                aSession.id = sessionID
                
                // client name and id
                let clientName = sessionData?["client"] as! String
                let clientID = sessionData?["clientID"] as! String
                aSession.clientName = clientName
                aSession.clientID = clientID
                
                // trainer details
                let trainerName = sessionData?["trainer"] as! String
                let trainerID = sessionData?["trainerID"] as! String
                aSession.trainerName = trainerName
                aSession.trainerID = trainerID
                
                // session details
                let startTime = sessionData?["startTime"] as! String
                let date = sessionData?["date"] as! String
                let location = sessionData?["location"] as! String
                
                // check if session is accepted
                if let value = sessionData?["accepted"] as? Bool {
                    aSession.accepted = value
                }
                
                aSession.startTime = startTime
                aSession.date = date
                aSession.location = location
                
                self.sessions?.append(aSession)
            }
            self.calendarDelegate?.updateSessionList(session: self.sessions!.reversed())
            
        }, withCancel: { (error) in
            // handle error
        })
    }
    
    // MARK: - Remove Database Observers
    func removeDatabaseObservers() {
        self.sessionsRef?.removeAllObservers()
    }
}
