//
//  AccountSelection.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-06.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

/*
 * Login to account, user is signed in
 */
/*
class AccountSelection: QuestionsButtonVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitleString(str: "Login As")
        self.setTopTitle(str: "Client")
        self.setBottomTitle(str: "Trainer")
    }
    
    // Go to client account dashboard
    override func topBtnNextPressed() {
        // check if client profile exists
        if !AuthService.instance.checkClientProfile() {
            let dashboard = Dashboard(initialAccount: Portals.client)
            let vtDashboard = VTDashboard()
            vtDashboard.dashboard = dashboard
            self.present(vtDashboard, animated: true, completion: nil)
        }
        else {
            let questions = QuestionsTableVC()
            self.present(questions, animated: true) {
                self.userDefaults.set(true, forKey: "Client")
                questions.questions = QuestionsFor.client
            }
        }
    }
    
    // Go to trainer account dashboard
    override func bottomBtnNextPressed() {
        // check if trainer profile exists
        if !AuthService.instance.checkTrainerProfile() {
            let dashboard = Dashboard(initialAccount: Portals.trainer)
            let vtDashboard = VTDashboard()
            vtDashboard.dashboard = dashboard
            self.present(vtDashboard, animated: true, completion: nil)
        }
        else {
            let questions = QuestionsTableVC()
            self.present(questions, animated: true) {
                self.userDefaults.set(true, forKey: "Trainer")
                questions.questions = QuestionsFor.trainer
            }
        }
    }
}
*/
