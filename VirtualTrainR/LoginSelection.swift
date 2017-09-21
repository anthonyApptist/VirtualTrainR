//
//  LoginSelection.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-27.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore

class LoginSelection: QuestionsButtonVC {
    
    // trainer or client
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLbl.text = "Login Options"
        
        self.setTopTitle(str: "Facebook Login")
        self.setBottomTitle(str: "Email Login")
        
        AuthService.instance.authDelegate = self
    }
    
    // MARK: - Facebook Login Selected
    override func topBtnNextPressed() {
        // facebook login manager
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile, .email], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                self.createAlertController(title: "Failed to Login to Facebook", message: error.localizedDescription, actionTitle: "OK", actionStyle: .cancel)
                break
            case .cancelled:
                break
            case .success(grantedPermissions: let grantedPermissions, declinedPermissions: let declinedPermissions, token: let accessToken): // let variables
                // do something with permissions
//                self.checkGranted(permissions: grantedPermissions, declinedPermissions: declinedPermissions)
//                AuthService.instance.authenticateFromFacebook(token: accessToken, type: )
                if AuthService.instance.checkUserExists() {
                    AuthService.instance.authenticateFromFacebook(token: accessToken.authenticationToken, info: nil)
                }
                else {
                    // go to basic profile w/ token
                    let authProfile = AuthProfile(type: AuthType.facebook)
                    authProfile.accessToken = accessToken.authenticationToken
                    let basicInfoVC = BasicInfoVC(profile: authProfile)
                    self.present(basicInfoVC, animated: true, completion: nil)
                }
                break
            }
        }
    }
    
    // MARK: - Email Login Selected
    override func bottomBtnNextPressed() {
        let loginVC = LogInVC()
        self.present(loginVC, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Check Facebook Granted Permissions
    func checkGranted(permissions: Set<Permission>, declinedPermissions: Set<Permission>) {
        if permissions.contains(Permission(name: "public_profile")) {
            self.userDefaults.set(true, forKey: "fbPublicProfile")
        }
        if permissions.contains(Permission(name: "email")) {
            self.userDefaults.set(true, forKey: "fbEmail")
        }
        if permissions.contains(Permission(name: "public_profile")) {
     
        }
    }
    */
}

// Authenticate Status (Facebook Login)
extension LoginSelection: AuthenticateStatus {
    // error
    func errorLoggingIn(error: Error) {
        self.hideActivityIndicator()
        self.createAlertController(title: error.localizedDescription, message: "Try again", actionTitle: "OK", actionStyle: .cancel)
    }
    
    // start
    func didStartLogin() {
        // do nothing, nothing to disable
        self.showActivityIndicator()
    }
    
    // signed in
    func didCompleteLogin() {
        self.hideActivityIndicator()
        // go to dashboard
        let vtDashboard = VTDashboard(initialAccount: Portals.client)
        let dashboard = Dashboard(vtDashboard: vtDashboard)
        self.present(dashboard, animated: true, completion: nil)
    }
}
