//
//  VTInbox.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-07.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol InboxUpdate {
    func updateInboxList(session: [Session])
}

class VTInbox: NSObject {
    
    // portal
    var portal: Portals?
    
    // inbox ref
    var inboxRef: DatabaseReference?
    
    // inbox update
    var inboxUpdate: InboxUpdate?
    
    // inbox
    var sessions: [Session]?
    
    init(portal: Portals) {
        super.init()
        
        self.portal = portal
    }
    
    // MARK: - Set up View
    func getInbox() {
        switch self.portal! {
        case .client:
            self.inboxForClient()
            break
        case .trainer:
            self.inboxForTrainer()
            break
        }
    }
    
    // MARK: - Set View for Client
    func inboxForClient() {
        
        let clientID = UserDefaults.standard.value(forKey: "clientID") as! String
        self.inboxRef = DataService.instance.clientRef.child(clientID).child("inbox")
        
        self.inboxRef?.observe(.value, with: { (snapshot) in
            self.sessions = []
            for child in snapshot.children.allObjects {
                let session = child as! DataSnapshot
                let sessionData = session.value as? NSDictionary
                
                // Session
                let aSession = Session()
                aSession.paid = false // default unpaid
                
                // unique session id
                let sessionID = session.key
                aSession.id = sessionID
                
                // trainer
                let trainerName = sessionData?["trainer"] as! String
                let trainerID = sessionData?["trainerID"] as! String
                aSession.trainerName = trainerName
                aSession.trainerID = trainerID
                
                // session details
                let startTime = sessionData?["startTime"] as! String
                let date = sessionData?["date"] as! String
                let location = sessionData?["location"] as! String
                
                aSession.startTime = startTime
                aSession.date = date
                aSession.location = location
                
                // check paid
                if let value = sessionData?["paid"] as? Bool {
                    aSession.paid = value
                }
                
                self.sessions?.append(aSession)
            }
            self.inboxUpdate?.updateInboxList(session: self.sessions!.reversed())
        })
    }
    
    // MARK: - Set View for Trainer
    func inboxForTrainer() {
        // none
    }
}
