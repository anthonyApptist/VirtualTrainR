//
//  VTLoadProfile.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-01.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol LoadProfileStatus {
    func didFinishLoadingProfile(_ user: User)
    func updateSetModel() // present model client or trainer from profile vc (parent)
}

// loads profile from memory or database
class VTLoadProfile: NSObject {
    
    // profile type
    var type: UserType?
    
    // delegate
    var loadInfo: LoadProfileStatus?
    
    // Init
    init(type: UserType) {
        super.init()
        
        self.type = type
    }
    
    // get user info
    func getUserInfo() {
        switch (self.type)! {
        case .client:
            self.getUserClientInfo()
            break
        case .trainer:
            self.getUserTrainerInfo()
            break
        default:
            self.updateProfileViewForDiscovery()
            break
        }
    }
    
    // MARK: - Get User Client Info (from memory)
    func getUserClientInfo() {
        
        // client
        var client = Client()
        
        let clientID = standardUserDefaults.value(forKey: "clientID") as! String
        client.accountID = clientID
        
        // check about me
        if let aboutMe = standardUserDefaults.value(forKey: "clientBio") as? String {
            client.aboutMe = aboutMe
        }
        
        // check locations
        if let location = standardUserDefaults.value(forKey: "locations") as? String {
            client.location = location
        }
        
        // basic info
        var basicInfo = BasicInfo()
        
        let firstName = standardUserDefaults.value(forKey: "firstName") as! String
        let lastName = standardUserDefaults.value(forKey: "lastName") as! String
        
        basicInfo.firstName = firstName
        basicInfo.lastname = lastName
        
        // if gender is available
        if let gender = standardUserDefaults.value(forKey: "gender") as? String {
            basicInfo.gender = gender
        }
        
        // if birthday is available
        if let birthdate = standardUserDefaults.value(forKey: "birthdate") as? String {
            basicInfo.birthdate = birthdate
        }
        
        // if profile photo is aviailable
        if let profilePhoto = standardUserDefaults.value(forKey: "clientPhoto") as? String {
            basicInfo.profilePicture = profilePhoto
        }
        
        // basic info for client
        client.basicInfo = basicInfo
        
        // full name 
        client.fullName = self.appendName(firstName, last: lastName)
        
        self.loadInfo?.didFinishLoadingProfile(client)
    }
    
    // MARK: - Get User Trainer Info (from memory)
    func getUserTrainerInfo() {
        // trainer
        var trainer = Trainer()
        
        let clientID = standardUserDefaults.value(forKey: "trainerID") as! String
        trainer.accountID = clientID
        
        // check about me if there is trainer specific one
        if let clientBio = standardUserDefaults.value(forKey: "clientBio") as? String {
            if let trainerBio = standardUserDefaults.value(forKey: "trainerBio") as? String {
                trainer.aboutMe = trainerBio
            }
            trainer.aboutMe = clientBio
        }
        
        // check locations
        if let certification = standardUserDefaults.value(forKey: "certification") as? String {
            trainer.certification = certification
        }
        
        // basic info
        var basicInfo = BasicInfo()
        
        let firstName = standardUserDefaults.value(forKey: "firstName") as! String
        let lastName = standardUserDefaults.value(forKey: "lastName") as! String
        
        basicInfo.firstName = firstName
        basicInfo.lastname = lastName
        
        // if gender is available
        if let gender = standardUserDefaults.value(forKey: "gender") as? String {
            basicInfo.gender = gender
        }
        
        // if birthday is available
        if let birthdate = standardUserDefaults.value(forKey: "birthdate") as? String {
            basicInfo.birthdate = birthdate
        }
        
        // if profile photo is aviailable
        if let clientProfilePhoto = standardUserDefaults.value(forKey: "clientPhoto") as? String {
            if let trainerProfilePhoto = standardUserDefaults.value(forKey: "trainerPhoto") as? String {
                basicInfo.profilePicture = trainerProfilePhoto
            }
            basicInfo.profilePicture = clientProfilePhoto
        }
        
        // basic info for trainer
        trainer.basicInfo = basicInfo
        
        // full name
        trainer.fullName = self.appendName(firstName, last: lastName)
        
        self.loadInfo?.didFinishLoadingProfile(trainer)
    }
    
    // MARK: - Update
    func updateProfileViewForDiscovery() {
        self.loadInfo?.updateSetModel()
    }
    
    // MARK: - Update User Info (user defaults)
    
    /*
    // MARK: - Trainer Info (from memory)
    func getTrainerInfo() {
        
        // basic info
        var basicInfo = BasicInfo()
        
        // basic info user defaults
        let firstName = UserDefaults.standard.value(forKey: "firstName") as! String
        let lastName = UserDefaults.standard.value(forKey: "lastName") as! String
        let gender = UserDefaults.standard.value(forKey: "gender") as! String
        let birthdate = UserDefaults.standard.value(forKey: "birthdate") as! String
     
        basicInfo.firstName = firstName
        basicInfo.lastname = lastName
        basicInfo.gender = gender
        basicInfo.birthdate = birthdate
        
        // trainer object
        let trainer = Trainer()
        trainer.basicInfo = basicInfo
        
        self.loadInfo?.didFinishLoadingProfile(trainer)
    }
    */
}
