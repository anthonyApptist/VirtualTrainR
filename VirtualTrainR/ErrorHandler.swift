//
//  ErrorHandler.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-17.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

typealias okResponse = () -> Void

class ErrorHandler: NSObject {
    
    // Error handler
    static let sharedInstance = ErrorHandler()
    let errorMessageView = MessageView()
    
    // show error message
    func show(message: String, container: UIViewController) {
        //Show Message View With Message
        errorMessageView.messageContent.text = message
        errorMessageView.offsetImagePosition()
        container.view.addSubview(errorMessageView)
        
    }
    
    // show error message with an alert
    func show(title: String, message: String, buttonText: String, container: UIViewController, onOK:okResponse) {
        //Show Alert View With Alert
    }
    
}
