//
//  AuthProfile.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-30.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FBSDKLoginKit

// class to handle sign in and account used

// Profile Data to update in view
protocol ProfileData {
    func errorGettingInfo(error: Error)
    func updateEmailLogin(basicInfo: BasicInfo)
    func updateFacebookLogin(basicInfo: BasicInfo)
}

// protocol sign in progress from auth service
protocol SignInProgress {
    func displayError(error: Error)
    func displayActivityView()
    func removeActivityView()
}

// Social Media Options for Info
enum AuthType {
    case email
    case facebook
}

class AuthProfile: NSObject, AuthenticateStatus {
    
    // auth type
    var authType: AuthType?
    
    // access token
    var accessToken: String?
    
    // email and password for email sign in
    var email: String?
    var password: String?
    
    // profile update delegate
    var profileDelegate: ProfileData?
    var signInProgress: SignInProgress?
    
    init(type: AuthType) {
        super.init()
        
        self.authType = type // set type of authentication
    }
    
    func getProfileInfo() {
        switch (self.authType)! {
        case .email:
            self.getEmailInfo()
            break
        case .facebook:
            self.getFacebookUserInfo()
            break
        }
    }
    
    // MARK: - Email Info (none)
    func getEmailInfo() {
        let basicInfo = BasicInfo()
        self.profileDelegate?.updateEmailLogin(basicInfo: basicInfo)
    }
    
    // MARK: - Facebook Info
    func getFacebookUserInfo() {
        if(FBSDKAccessToken.current() != nil) {
            // print(FBSDKAccessToken.current().permissions)
            // request facebook id, name (seperated), email, birthday, gender, profile pic
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, first_name, last_name, gender, about"])
            
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                if error != nil {
                    self.profileDelegate?.errorGettingInfo(error: error!)
                }
                else {
                    // requested data in dictionary
                    let data = result as! [String : AnyObject]
                    
                    // facebook user id to access friends and other lists
                    let fbID = data["id"] as? String
                    
                    // facebook account name
                    let firstName = data["first_name"] as? String
                    let lastName = data["last_name"] as? String
                    
                    // profile gender
                    let gender = data["gender"]?.capitalized
                    
                    // about
                    let aboutMe = data["about"] as? String
                    
                    /*
                    // profile birthday (need facebook review first)
                    let birthday = data["birthday"] as? String
                    let birthdate = self.dateStringConvert(date: birthday)
                    */
                    
                    // picture (large)
                    let pictureUrlString = "https://graph.facebook.com/\(fbID!)/picture?type=large&return_ssl_resources=1"
                    DataService.instance.saveFacebookPhoto(url: pictureUrlString)
                    
                    // basic info
                    var basicInfo = BasicInfo()
                    
                    // basic info variables 
                    basicInfo.firstName = firstName
                    basicInfo.lastname = lastName
                    basicInfo.gender = gender
                    basicInfo.profilePicture = pictureUrlString
                    basicInfo.fbAboutMe = aboutMe
                    
                    // update view
                    self.profileDelegate?.updateFacebookLogin(basicInfo: basicInfo)
                }
            })
            connection.start()
        }
    }
    
    // MARK: - Sign in New User
    func signInNewUser(_withBasicInfo info: BasicInfo) {
        switch self.authType! {
        case .email:
            AuthService.instance.login(email: self.email!, password: self.password!, info: info)
        case .facebook:
            AuthService.instance.authenticateFromFacebook(token: self.accessToken!, info: info)
        }
        
    }
    
    // MARK: - Authenticate Status
    func errorLoggingIn(error: Error) {
        self.signInProgress?.displayError(error: error)
    }
    
    func didStartLogin() {
        self.signInProgress?.displayActivityView()
    }
    
    func didCompleteLogin() {
        self.signInProgress?.removeActivityView()
    }
}
