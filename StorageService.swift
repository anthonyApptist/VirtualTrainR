//
//  StorageService.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-30.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService: DataBase {
    // public instance
    private static let _instance = StorageService()
    
    static var instance: StorageService {
        return _instance
    }
    
    // MARK: - Store Profile Image for Client/Trainer Account
    func storeProfileImage(inAccount type: Portals, imageData: Data) {
        let storageID = standardUserDefaults.value(forKey: "storageID") as! String
        var nameOfPhoto: String = ""
        
        if type == .client {
            nameOfPhoto = "clientProfilePhoto"
        }
        if type == .trainer {
            nameOfPhoto = "trainerProfilePhoto"
        }
        
        // store in firebase storage
        self.mainStorageRef.child(storageID).child(nameOfPhoto).putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                // handle error
            }
            else {
                let storageRef = metadata?.downloadURL()?.absoluteString
                
                // store in database
                DataService.instance.savePhoto(reference: storageRef!, type: type)
            }
        }
    }
}
