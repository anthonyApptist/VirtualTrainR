//
//  Discover.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-05.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol UpdateDiscoverList {
    func updateTrainerList(_ trainers: [Trainer])
    func updateClientList(_ clients: [Client])
}

class VTDiscover: NSObject {
    
    // portals
    var portal: Portals?
    
    // trainers database
    var discoverRef: DatabaseReference?
    
    // trainers
    var allTrainers: [Trainer]? = []
    
    // clients
    var allClients: [Client]? = []
    
    // delegate
    var updateDiscoverDelegate: UpdateDiscoverList?
    
    // Init
    init(portal: Portals) {
        super.init()
        
        self.portal = portal
    }
    
    // MARK: - Set up View
    func startDiscovering() {
        switch self.portal! {
        case .client:
            self.discoverForClient()
            break
        case .trainer:
            self.discoverForTrainer()
            break
        }
    }
    
    // MARK: - Set View for Client
    func discoverForClient() {
        self.discoverRef = DataService.instance.trainerRef
        
        self.discoverRef?.observe(.value, with: { (snapshot) in
            
            self.allTrainers = []
            
            for trainer in snapshot.children.allObjects {
                let aTrainer = Trainer() // trainer
                
                let trainerProfile = trainer as! DataSnapshot
                let trainerData = trainerProfile.value as? NSDictionary
                
                let trainerID = trainerProfile.key
                
                aTrainer.accountID = trainerID
                
                let firstName = trainerData?["firstName"] as? String
                let lastName = trainerData?["lastName"] as? String
                let email = trainerData?["email"] as? String
                
                // basic info struct
                var basicinfo = BasicInfo()
                basicinfo.firstName = firstName
                basicinfo.lastname = lastName
                aTrainer.email = email
                
                // Optionals
                
                // check for profile photo
                if let trainerProfilePhoto = trainerData?["trainerProfilePhoto"] as? String {
                    basicinfo.profilePicture = trainerProfilePhoto
                }
                
                // check for bio
                if let trainerBio = trainerData?["aboutMe"] as? String {
                    aTrainer.aboutMe = trainerBio
                }
                
                // check for certs
                if let trainerCerts = trainerData?["certification"] as? String {
                    aTrainer.certification = trainerCerts
                }
                
                aTrainer.basicInfo = basicinfo
                aTrainer.fullName = self.appendName(firstName!, last: lastName!)
                
                self.allTrainers?.append(aTrainer)
            }
            // update
            self.updateDiscoverDelegate?.updateTrainerList(self.allTrainers!)
            
        }) { (error) in
            // error
        }
    }
    
    // MARK: - Set View for Trainer
    func discoverForTrainer() {
        self.discoverRef = DataService.instance.clientRef
        
        self.discoverRef?.observe(.value, with: { (snapshot) in
            
            self.allClients = []
            
            for client in snapshot.children.allObjects {
                let aClient = Client() // client
                
                let clientProfile = client as! DataSnapshot
                let clientData = clientProfile.value as? NSDictionary
                
                let clientID = clientProfile.key
                
                aClient.accountID = clientID
                
                let firstName = clientData?["firstName"] as? String
                let lastName = clientData?["lastName"] as? String
                let email = clientData?["email"] as? String
                
                // basic info struct
                var basicinfo = BasicInfo()
                basicinfo.firstName = firstName
                basicinfo.lastname = lastName
                aClient.email = email
                
                // Optionals
                
                // check for profile photo
                if let clientProfilePhoto = clientData?["profilePhoto"] as? String {
                    basicinfo.profilePicture = clientProfilePhoto
                }
                
                // check for bio
                if let clientBio = clientData?["aboutMe"] as? String {
                    aClient.aboutMe = clientBio
                }
                
                // check for locations
                if let clientLocations = clientData?["location"] as? String {
                    aClient.location = clientLocations
                }
                
                aClient.basicInfo = basicinfo
                aClient.fullName = self.appendName(firstName!, last: lastName!)
                
                self.allClients?.append(aClient)
            }
            // update
            self.updateDiscoverDelegate?.updateClientList(self.allClients!)
            
        }) { (error) in
            // error
        }
    }
}
