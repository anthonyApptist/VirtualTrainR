//
//  MessageView.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-17.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class MessageView: UIView {
    
    
    // View
    var messageContent: LabelCustomSpacing!
    var startPositionY: CGFloat = 0.0
    var messageShow = false
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: -70, width: UIScreen.main.bounds.width, height: 70))
        self.backgroundColor = UIColor.white
        startPositionY = self.layer.position.y
        self.messageContent = LabelCustomSpacing(frame: CGRect(x: 68, y: 16, width: 240, height: 38))
        self.messageContent.textColor = UIColor.black
        self.messageContent.font = UIFont.init(name: "SFUIText-Light", size: 13)
        self.messageContent.numberOfLines = 0
        self.messageContent.textAlignment = .center
        self.messageContent.alpha = 0.0
        self.messageContent.text = "hi"
        self.messageContent.setSpacing(space: 0.5)
        self.messageContent.lineBreakMode = .byWordWrapping
        
        self.addSubview(messageContent)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
    }

    // MARK: - Animate Error Message
    func offsetImagePosition() {
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 70)
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0) {
            self.messageContent.alpha = 1.0
            sleep(3)
            self.resetImagePosition()
        }
        
        messageShow = true
        
    }
    
    // MARK: - Reset Error Message
    func resetImagePosition() {
        
        if messageShow == true {
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: -70)
            }, completion: nil)
            
            messageShow = false
        }
    }
    
    
    
    
}
