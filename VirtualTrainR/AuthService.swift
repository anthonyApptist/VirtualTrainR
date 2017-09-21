//
//  AuthService.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-20.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FacebookLogin

// status of authentication (add new function for login before block)
protocol AuthenticateStatus {
    func errorLoggingIn(error: Error)
    func didStartLogin()
    func didCompleteLogin()
}

protocol SignOutStatus {
    func errorSigningOut()
    func didPerformSignOut()
}

class AuthService: DataBase {
    let app = UIApplication.shared.delegate as! AppDelegate
    
    // public instance
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    // authenticate status delegate
    var authDelegate: AuthenticateStatus?
    var signoutDelegate: SignOutStatus?
    
    // MARK: - Login With Email
    func login(email: String, password: String, info: BasicInfo?) {
        self.authDelegate?.didStartLogin()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                // user not found
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    if errCode == .userNotFound {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.authDelegate?.errorLoggingIn(error: error!)
                            }
                            else {
                                let newClient = self.createClient(uid: user!.uid, email: user!.email!, info: info!)
                                // create new user in database
                                DataService.instance.saveNewUser(newClient)
                                self.authDelegate?.didCompleteLogin()
                            }
                        })
                    }
                }
            }
            else {
                // signed in user
                self.authDelegate?.didCompleteLogin()
            }
        }
    }
    
    // MARK: - Login with Facebook
    func authenticateFromFacebook(token: String, info: BasicInfo?) {
        self.authDelegate?.didStartLogin()
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                self.authDelegate?.errorLoggingIn(error: error!)
            }
            else {
                // facebook logged in
                // user has created an account
                if self.checkUserExists() {
                    // complete login and sign user in as client
                    self.authDelegate?.didCompleteLogin()
                }
                // create new user uid on database and save to database
                else {
                    let newClient = self.createClient(uid: user!.uid, email: user!.email!, info: info!)
                    DataService.instance.saveNewUser(newClient)
                    self.authDelegate?.didCompleteLogin()
                }
            }
        }
    }
    
    // MARK: - Create Client
    func createClient(uid: String, email: String, info: BasicInfo) -> Client {
        let client = Client()
        
        // check facebook about me
        if let aboutMe = info.fbAboutMe {
            client.aboutMe = aboutMe
        }
        
        client.uid = uid
        client.email = email
        client.basicInfo = info
        print(client.uid ?? "")
        print(client.email ?? "")
        print(client.basicInfo?.firstName ?? "")
        print(client.basicInfo?.lastname ?? "")
        print(client.basicInfo?.gender ?? "")
        print(client.basicInfo?.birthdate ?? "")
        return client
    }
    
    // MARK: - Check Signed In User
    func checkSignedIn() -> Bool {
        // check if user is signed in
        if Auth.auth().currentUser != nil {
            return true
        }
        else {
            return false
        }
    }
    
    // MARK: - Check User Exists
    func checkUserExists() -> Bool {
        if standardUserDefaults.value(forKey: "uid") != nil {
            return true
        }
        else {
            return false
        }
    }
    
    // MARK: - Check for Trainer Profile IDs
    func checkTrainerProfile() -> Bool { // if exist return true
        if standardUserDefaults.value(forKey: "trainerID") != nil {
            return true
        }
        else {
            return false
        }
    }
    
    // MARK: - Sign out of account
    func performSignOut() {
        // successfully signed out
        try! Auth.auth().signOut()
    }
}
