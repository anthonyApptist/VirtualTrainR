//
//  VerificationStack.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-16.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class VerificationStack: UIStackView {
    
    // Images
    let fbImage = #imageLiteral(resourceName: "facebook_verify_ic.png") // facebook_verify_ic.png
    let emailImage = #imageLiteral(resourceName: "email_verify_ic.png") // email_verify_ic.png
    
    // Image views
    var fbImageView: UIImageView?
    var emailImageView: UIImageView?
//    var googleImageView: UIImageView?
//    var linkedInImageView: UIImageView?
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // stack view properties
        self.spacing = 5
        
        // fb image view
        fbImageView = UIImageView()
        fbImageView?.image = fbImage
        fbImageView?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        fbImageView?.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        
        // email image view
        emailImageView = UIImageView()
        emailImageView?.image = emailImage
        emailImageView?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        emailImageView?.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
    }
    
    // MARK: - Insert
    func insertVerification(_ verified: Verifications, number: Int) {
        switch verified {
        case .facebook:
            self.insertSubview(fbImageView!, at: number)
            break
        case .email:
            self.insertSubview(emailImageView!, at: number)
            break
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
