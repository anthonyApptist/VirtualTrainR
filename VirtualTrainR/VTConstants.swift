//
//  VTConstants.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-16.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Colours
let kBarTintColor = UIColor.init(red: 57/255, green: 95/255, blue: 167/255, alpha: 1.0)

// MARK: - entry button backgrounds
let kSplashScreenFill = #imageLiteral(resourceName: "splash_screen_fill_button.png") // splash_screen_fill_button.png
let kSplashScreenBorder = #imageLiteral(resourceName: "splash_screen_border_button.png") // splash_screen_border_button.png

// fonts
let standardFont = "SFUIText-Light"
let heavyFont = "SFUIDisplay-Heavy"
let subtitleFont = "SFUIText-LightItalic"
let thinFont = "SFUIDisplay-Thin"

// user defaults standard
let standardUserDefaults = UserDefaults.standard

// pictures
let defaultProfileImg = #imageLiteral(resourceName: "profile_ic.png") // profile_ic.png

// MARK: - Enums
enum Verifications { // verifications for different sign in
    case facebook
    case email
}

enum TabBarName: String { // Tab bar names
    case calendar = "Calendar"
    case discover = "Discover"
    case inbox = "Inbox"
    case profile = "Profile"
}

enum Portals { // client or trainer portals
    case client
    case trainer
}

enum UserType { // determine which type of user for profile viewing
    case client
    case trainer
    case discoverClient
    case discoverTrainer
}

enum EditingViewTitle: String { // for class EditingProfileVC
    case bio = "Edit Bio"
    case location = "Edit Location"
    case certification = "Edit Certification"
}

