//
//  DataService.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-22.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FirebaseDatabase

// Functions to save objects to database

class DataService: DataBase {
    // public instance
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    // complete new trainer
    var newTrainerDelegate: CompleteNewTrainer?
    
    
    // MARK: - Create New Client on Database
    func saveNewUser(_ client: Client) {
        // save new firebase uid
        let uid = client.uid!
        standardUserDefaults.set(uid, forKey: "uid")
        
        // save new client profile id
        let clientProfileID = self.createUniqueID() // unique id for new client profile
        standardUserDefaults.set(clientProfileID, forKey: "clientID")
        
        // new storage id
        let storageID = self.createUniqueID() // unique id for storage 
        standardUserDefaults.set(storageID, forKey: "storageID")
        
        // client profile
        var clientUpdates = self.createProfileForClient(client)
        
        if let clientProfilePhoto = standardUserDefaults.value(forKey: "clientPhoto") as? String {
            clientUpdates.updateValue(clientProfilePhoto, forKey: "clientProfilePhoto")
        }
        
        if let aboutMe = client.aboutMe {
            clientUpdates.updateValue(aboutMe, forKey: "aboutMe")
        }
        
        // save to database
        self.clientRef.child(clientProfileID).updateChildValues(clientUpdates)
        
        clientUpdates.removeValue(forKey: "aboutMe")
        
        var userUpdates = clientUpdates
        
        userUpdates.updateValue(clientProfileID, forKey: "clientID")
        userUpdates.updateValue(storageID, forKey: "storageID")
        
        self.userRef.child(uid).updateChildValues(userUpdates)
    }
    
    // MARK: - Create New Trainer on Database
    func saveNewTrainer() {
        let userUID = standardUserDefaults.value(forKey: "uid") as! String
        
        // save new trainer profile id
        let trainerProfileID = self.createUniqueID() // unique id for new trainer profile
        standardUserDefaults.set(trainerProfileID, forKey: "trainerID")
        
        // new trainer profile (from created client info)
        var trainerProfile: [String:String] = [:]
        
        let firstName = standardUserDefaults.value(forKey: "firstName") as! String
        let lastName = standardUserDefaults.value(forKey: "lastName") as! String
        let email = standardUserDefaults.value(forKey: "email") as! String
        
        trainerProfile.updateValue(firstName, forKey: "firstName")
        trainerProfile.updateValue(lastName, forKey: "lastName")
        trainerProfile.updateValue(email, forKey: "email")
        
        // if gender was entered from client account
        if let gender = standardUserDefaults.value(forKey: "gender") as? String {
            trainerProfile.updateValue(gender, forKey: "gender")
        }
        
        // if birthday was entered from client account
        if let birthdate = standardUserDefaults.value(forKey: "birthdate") as? String {
            trainerProfile.updateValue(birthdate, forKey: "birthdate")
        }
        
        // if about me was entered from client account
        if let clientBio = standardUserDefaults.value(forKey: "clientBio") as? String {
            trainerProfile.updateValue(clientBio, forKey: "aboutMe")
        }
        
        // if profile photo was entered from client account
        if let clientProfilePhoto = standardUserDefaults.value(forKey: "clientPhoto") as? String {
            trainerProfile.updateValue(clientProfilePhoto, forKey: "trainerProfilePhoto")
        }
        
        // save to database
        self.trainerRef.child(trainerProfileID).updateChildValues(trainerProfile)
        
        let userUpdates = ["trainerID": trainerProfileID]
        
        self.userRef.child(userUID).updateChildValues(userUpdates)
        
        self.newTrainerDelegate?.didCreateNewTrainer()
    }


    // MARK: - Create Client Profile
    func createProfileForClient(_ client: Client) -> [String:Any] {
        var jsonObject: [String:Any] = [:]
        
        // user info
        let email = client.email
        
        // basic info
        let firstName = client.basicInfo?.firstName
        let lastName = client.basicInfo?.lastname
        
        jsonObject.updateValue(email!, forKey: "email")
        jsonObject.updateValue(firstName!, forKey: "firstName")
        jsonObject.updateValue(lastName!, forKey: "lastName")
        
        if let gender = client.basicInfo?.gender {
            jsonObject.updateValue(gender, forKey: "gender")
        }
        
        if let birthdate = client.basicInfo?.birthdate {
            jsonObject.updateValue(birthdate, forKey: "birthdate")
        }
        
        // save to user defaults
        self.saveInfoToUserDefaults(object: jsonObject)
        
        return jsonObject
    }
    
    /*
    // MARK: - Create Trainer Profile
    func createProfileForTrainer(_ trainer: Trainer) -> [String:Any] {
        var jsonObject: [String:Any] = [:]
        
        // user info
        let email = trainer.email
        
        // basic info
        let firstName = trainer.basicInfo?.firstName
        let lastName = trainer.basicInfo?.lastname
        
        jsonObject.updateValue(email!, forKey: "email")
        jsonObject.updateValue(firstName!, forKey: "firstName")
        jsonObject.updateValue(lastName!, forKey: "lastName")
        
        if let gender = trainer.basicInfo?.gender {
            jsonObject.updateValue(gender, forKey: "gender")
        }
        
        if let birthdate = trainer.basicInfo?.birthdate {
            jsonObject.updateValue(birthdate, forKey: "birthdate")
        }
        
        return jsonObject
    }
    */
    
    // MARK: - Save Firebase to UserDefaults
    func saveInfoToUserDefaults(object: Dictionary<String, Any>) {
        for key in object.keys {
            let value = object[key]
            standardUserDefaults.set(value, forKey: key)
        }
    }
    
    // MARK: - Save Editable Profile Info
    func saveEditableInfo(forInfoType type: EditingViewTitle, text: String, account: UserType) {
        switch type {
        case .bio:
            let update: [String:String] = ["aboutMe": text]
            if account == .client {
                let clientID = standardUserDefaults.value(forKey: "clientID") as! String
                self.clientRef.child(clientID).updateChildValues(update)
                // save as client's about me text
                standardUserDefaults.set(text, forKey: "clientBio")
            }
            if account == .trainer {
                let trainerID = standardUserDefaults.value(forKey: "trainerID") as! String
                self.trainerRef.child(trainerID).updateChildValues(update)
                // save as trainer's about me text
                standardUserDefaults.set(text, forKey: "trainerBio")
            }
            break
        case .location:
            let update: [String:String] = ["location": text]
            let clientID = standardUserDefaults.value(forKey: "clientID") as! String
            self.clientRef.child(clientID).updateChildValues(update)
            // save to user defaults
            standardUserDefaults.set(text, forKey: "locations")
            break
        case .certification:
            let update: [String:String] = ["certification": text]
            let trainerID = standardUserDefaults.value(forKey: "trainerID") as! String
            self.trainerRef.child(trainerID).updateChildValues(update)
            // save to user defaults
            standardUserDefaults.set(text, forKey: "certification")
            break
        }
    }
    
    // MARK: - Save Photo
    func savePhoto(reference: String, type: Portals) {
        let uid = standardUserDefaults.value(forKey: "uid") as! String // firebase uid
        if type == .client {
            let clientID = standardUserDefaults.value(forKey: "clientID") as! String
            let update: [String:String] = ["clientProfilePhoto":reference]
            self.clientRef.child(clientID).updateChildValues(update)
            self.userRef.child(uid).updateChildValues(update)
            // save to user defaults
            standardUserDefaults.set(reference, forKey: "clientPhoto")
        }
        if type == .trainer {
            let trainerID = standardUserDefaults.value(forKey: "trainerID") as! String
            let update: [String:String] = ["trainerProfilePhoto":reference]
            self.trainerRef.child(trainerID).updateChildValues(update)
            self.userRef.child(uid).updateChildValues(update)
            // save to user defaults
            standardUserDefaults.set(reference, forKey: "trainerPhoto")
        }
    }
    
    // MARK: - Save Facebook Photo
    func saveFacebookPhoto(url: String) {
        // save facebook picture url to standard defaults
        standardUserDefaults.set(url, forKey: "clientPhoto")
    }
    
    /*
    // MARK: - Verify Social Media on Database
    func verify(account: SocialMediaAccount, type: AccountType) {
        switch account {
        case .email:
            let existingUID = UserDefaults.standard.value(forKey: "FirebaseUID") as! String
            if type == .client {
                let clientProfileID = UserDefaults.standard.value(forKey: "clientID") as! String
                
                let updates = ["emailVerified": true]
                
                // verify
                self.updateVerification(uid: existingUID, profileID: clientProfileID, updates: updates, type: type)
            }
            if type == .trainer {
                let trainerID = UserDefaults.standard.value(forKey: "trainerID") as! String
                let updates = ["emailVerified": true]
                // verify email
                self.updateVerification(uid: existingUID, profileID: trainerID, updates: updates, type: type)
            }
            break
        case .facebook:
            // existing uid
            let existingUID = UserDefaults.standard.value(forKey: "FirebaseUID") as! String
            if type == .client {
                let clientProfileID = UserDefaults.standard.value(forKey: "clientID") as! String
                let updates = ["facebook":true]
                self.updateVerification(uid: existingUID, profileID: clientProfileID, updates: updates, type: type)
            }
            if type == .trainer {
                let trainerID = UserDefaults.standard.value(forKey: "trainerID") as! String
                let updates = ["facebook":true]
                // verify facebook
                self.updateVerification(uid: existingUID, profileID: trainerID, updates: updates, type: type)
            }
            break
        }
    }
 */
    
    // MARK: - Update Verification
    func updateVerification(uid: String, profileID: String, verification: Verifications) {
        
    }
 
    // MARK: - Save Training Session w/ Trainer
    func saveTrainingSession(_ session: Session) { // sent to trainer calendar (accept or decline)
        
        // session details
        let sessionStartTime = session.startTime!
        let sessionDate = session.date!
        let sessionLocation = session.location!
        
        // trainer name and id
        let trainerName = session.trainerName
        let trainerID = session.trainerID
        
        // user, one making the appointment (client)
        let firstName = UserDefaults.standard.value(forKey: "firstName") as! String
        let lastName = UserDefaults.standard.value(forKey: "lastName") as! String
        let clientID = UserDefaults.standard.value(forKey: "clientID") as! String
        
        let clientName = firstName + " " + lastName
        
        let sessionUpdate: [String:Any] = ["startTime": sessionStartTime, "date": sessionDate, "location": sessionLocation, "client": clientName, "trainer": trainerName!, "clientID": clientID, "trainerID": trainerID!]
        
        let sessionID = self.createUniqueID() // create unique session id
        
//        self.clientRef.child(clientID).child("sessions").child(sessionID).updateChildValues(sessionUpdate)
        self.trainerRef.child(trainerID!).child("sessions").child(sessionID).updateChildValues(sessionUpdate)
    }
    
    // MARK: - Trainer Accepted Session (write to client node)
    func saveTrainerAcceptedSession(_ session: Session) {
        // unique session id
        let sessionID = session.id!
        
        // client id
        let clientID = session.clientID!
        
        // session details
        let startTime = session.startTime
        let date = session.date
        let location = session.location
        
        // trainer
        let trainerName = session.trainerName
        let trainerID = session.trainerID!
        
        let sessionUpdate: [String:Any] = ["startTime": startTime!, "date": date!, "location": location!, "trainer": trainerName!, "trainerID": trainerID]
        
        // save to client inbox
        self.clientRef.child(clientID).child("inbox").child(sessionID).updateChildValues(sessionUpdate)
        
        // trainer update for accepted
        let trainerUpdates: [String:Any] = ["accepted": true]
        self.trainerRef.child(trainerID).child("sessions").child(sessionID).updateChildValues(trainerUpdates)
    }
    
    // MARK: - Trainer Declined Session (remove)
    func removeTrainerDeclinedSession(_ sessionID: String) {
        let trainerID = standardUserDefaults.value(forKey: "trainerID") as! String
        self.trainerRef.child(trainerID).child("sessions").child(sessionID).removeValue()
    }
    
    // MARK: - Create Charge for Stripe
    func saveApplePayToken(_ session: Session, token: String) { // paid, create on client calendar
        let clientID = standardUserDefaults.value(forKey: "clientID") as! String
        let sessionID = session.id!
        self.clientRef.child(clientID).child("payments").child(sessionID).child("pay").setValue(token)
        
        // session details
        let startTime = session.startTime
        let date = session.date
        let location = session.location
        
        // trainer
        let trainerName = session.trainerName
        let trainerID = session.trainerID!
        
        let sessionUpdate: [String:Any] = ["startTime": startTime!, "date": date!, "location": location!, "trainer": trainerName!, "trainerID": trainerID]
        
        // set to client calendar
        self.clientRef.child(clientID).child("sessions").child(sessionID).updateChildValues(sessionUpdate)
        
        // update paid bool in client inbox ref
        self.clientRef.child(clientID).child("inbox").child(sessionID).updateChildValues(["paid":true])
    }
    
    // MARK: - Set Location for Trainer
    func setOnlineStatus(latitude: Double, longitude: Double) {
        // first name, last name and trainer id as key
        let trainerID = UserDefaults.standard.value(forKey: "trainerID") as! String
        let firstName = UserDefaults.standard.value(forKey: "firstName") as? String
        let lastName = UserDefaults.standard.value(forKey: "lastName") as? String
        let onlineStatus: [String:Any] = ["firstName": firstName!, "lastName": lastName!, "latitude": latitude, "longitude":longitude]
        self.onlineRef.child(trainerID).updateChildValues(onlineStatus)
    }
    
    // MARK: - Remove Online Status for Trainer
    func removeOnlineStatus() {
        // remove trainer id 
        let trainerID = UserDefaults.standard.value(forKey: "trainerID") as! String
        self.onlineRef.child(trainerID).removeValue()
    }
}

