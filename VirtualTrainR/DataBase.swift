//
//  DataBase.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-22.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

// User Account Type
enum AccountType {
    case client
    case trainer
}

// Initial Account Variables
enum AccountVariables: String {
    case uid = "uid"
    case email = "email"
}

// Social Media Accounts
enum SocialMediaAccount {
    case email
    case facebook
}

// Database references and convenience functions 

class DataBase {
    
    // MARK: - Database References
    
    // main ref
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    // public ref
    var publicRef: DatabaseReference {
        return mainRef.child("public")
    }
    
    // users ref
    var userRef: DatabaseReference {
        return mainRef.child("users")
    }
    
    // client profiles ref
    var clientRef: DatabaseReference {
        return publicRef.child("client")
    }
    
    // trainer profiles ref
    var trainerRef: DatabaseReference {
        return publicRef.child("trainer")
    }
    
    // online trainers ref
    var onlineRef: DatabaseReference {
        return publicRef.child("online")
    }
    
    // MARK: - Storage References
    var mainStorageRef: StorageReference {
        return Storage.storage().reference(forURL: "gs://virtualtrainr-24620.appspot.com/")
    }
    
    // MARK: - Unique ID
    func createUniqueID() -> String {
        return NSUUID().uuidString
    }
    
    // MARK: - Check Basic Info Entered
    func checkBasicInfo() -> Bool {
        return standardUserDefaults.bool(forKey: "basicInfo")
    }
    
    // MARK: - Database Profile Entries True
    func createSection(array: [String]) -> [String:Bool] {
        var section: [String:Bool] = [:]
        for arrayItem in array {
            section.updateValue(true, forKey: arrayItem)
        }
        return section
    }
}
