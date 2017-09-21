//
//  ProfileTitleView.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-29.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class ProfileTitleView: UIView {
    
    // paths
    var leftPath = UIBezierPath()
    var rightPath = UIBezierPath()
    
    // title label
    var titleLabel: UILabel?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        // title
        titleLabel = UILabel()
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = self.createFontWithSize(fontName: standardFont, size: 15.0)
        titleLabel?.textColor = UIColor.black
        titleLabel?.textAlignment = .center
        self.addSubview(titleLabel!)
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        titleLabel?.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print(rect)
        
        // left side of title label
        leftPath.lineWidth = 1.0
        leftPath.move(to: CGPoint(x: 10, y: rect.midY))
        leftPath.addLine(to: CGPoint(x: titleLabel!.frame.minX - 10, y: rect.midY))
        
        UIColor.black.setStroke()
        leftPath.stroke()
        
        UIColor.black.setFill()
        leftPath.fill()
        
        // right side of title label
        rightPath.lineWidth = 1.0
        rightPath.move(to: CGPoint(x: titleLabel!.frame.maxX + 10, y: rect.midY))
        rightPath.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.midY))
        
        UIColor.black.setStroke()
        rightPath.stroke()
        
        UIColor.black.setFill()
        rightPath.fill()
    }
}
