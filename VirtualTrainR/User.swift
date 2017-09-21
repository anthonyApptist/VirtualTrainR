//
//  User.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-14.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import CoreLocation

// Default User class

class User {
    
    // firebase account info
    var uid: String?
    var email: String?
    
    // user Information
    var basicInfo: BasicInfo?
    var aboutMe: String?
//    var preferences: Preferences?
    
    // Init
    init() {
        self.basicInfo = BasicInfo()
        self.aboutMe = nil
//        self.preferences = Preferences()
    }
    
    // Set variables
    func setUserInformation(basic: BasicInfo, bio: String?) {
        self.basicInfo = basic
        self.aboutMe = bio
//        self.preferences = preferences
    }
}

// User basic info
struct BasicInfo {
    var profilePicture: String? // URL for the profile picture
    var firstName: String?
    var lastname: String?
    var gender: String?
    var birthdate: String?
    var fbAboutMe: String?
}
