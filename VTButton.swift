//
//  VTButton.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-17.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

// Base UIButton class
class VTButton: UIButton {
    
//    var type = UIButtonType(rawValue: 0) // button type is system
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // button set up defaults
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    /*
    convenience init(type: UIButtonType) {
        self.init()
        self.type = type
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Round Button
class RoundVTButton: VTButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.opacity = 0.2
        self.layer.cornerRadius = 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Round Button w/ image view
class ImageVTButton: RoundVTButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView?.contentMode = .scaleAspectFit
        self.titleLabel?.contentMode = .right
        self.backgroundColor = UIColor.lightText
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.imageEdgeInsets = UIEdgeInsets(top: 20, left: -270, bottom: 20, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/*
class ItemButton: UIButton {
    
    let innerCircle = UIView()
    var titleLbl = UILabel()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        let radius = self.frame.width/8
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        self.layer.borderWidth = 1
        self.titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.text = "item"
        titleLbl.font = UIFont(name: "SFUIText-Light", size: 12)
        self.addSubview(titleLbl)
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        titleLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        innerCircle.backgroundColor = UIColor.lightGray
        innerCircle.alpha = 0.3
        innerCircle.layer.borderWidth = 1
        innerCircle.layer.borderColor = UIColor.lightGray.cgColor
        innerCircle.layer.cornerRadius = 15
        innerCircle.clipsToBounds = true
        self.addSubview(innerCircle)
        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        innerCircle.widthAnchor.constraint(equalToConstant: 25).isActive = true
        innerCircle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        innerCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        innerCircle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3).isActive = true
        
        let cut = UIView()
        innerCircle.addSubview(cut)
        cut.backgroundColor = UIColor.darkGray
        cut.translatesAutoresizingMaskIntoConstraints = false
        cut.centerYAnchor.constraint(equalTo: innerCircle.centerYAnchor).isActive = true
        cut.centerXAnchor.constraint(equalTo: innerCircle.centerXAnchor).isActive = true
        cut.widthAnchor.constraint(equalTo: innerCircle.widthAnchor, multiplier: 0.3).isActive = true
        cut.heightAnchor.constraint(equalTo: innerCircle.heightAnchor, multiplier: 0.07).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        let radius = self.frame.width/2
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
    }
}

class ItemButtonBlue: ItemButton {
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        let radius = self.frame.width/8
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.titleLbl.textColor = UIColor.white
        self.titleLbl.textAlignment = .center
        self.backgroundColor = UIColor.init(red: 63/255, green: 108/255, blue: 171/255, alpha: 1.0)
        
        innerCircle.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        let radius = self.frame.width/2
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

class SelectedItemButton: ItemButton {
    
    let blueCol = UIColor.init(red: 55/255, green: 97/255, blue: 161/255, alpha: 1.0)
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        
        innerCircle.removeFromSuperview()
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        titleLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLbl.textAlignment = .center
        titleLbl.textColor = UIColor.black
        
        self.layer.borderColor = blueCol.cgColor
        
        self.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
    }
    
    func setPressed() {
        self.backgroundColor = blueCol
        self.isSelected = true
        titleLbl.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func btnPressed() {
        if(!self.isSelected) {
            self.backgroundColor = blueCol
            self.isSelected = true
            titleLbl.textColor = UIColor.white
            
        }
            
        else if(self.isSelected) {
            self.backgroundColor = UIColor.white
            self.isSelected = false
            titleLbl.textColor = UIColor.black
        }
    }
    
}
*/



