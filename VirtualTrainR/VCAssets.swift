//
//  BaseVC.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-14.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

/*
 * Default UIViewController class with various helper variables for making views
 */

class VCAssets: UIViewController {
    
    // activity view
    var activityView: UIActivityIndicatorView?
    
    // screen image assets
    let backBtnImage = UIImage(named: "back_icon")
    let vtImage = UIImage(named: "vt_icon")
    let backgroundImage = UIImage(named: "intro_background")
    
    var fontSize: CGFloat {
        get {
            return 15.0
        }
        set {
            self.fontSize = newValue
        }
    }
    
    // app delegate for sign out
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // nav bar height
    var navBarHeight: CGFloat? {
        return self.navigationController?.navigationBar.frame.height
    }
    
    // tab bar height
    var tabBar: UITabBar? {
        return self.tabBarController?.tabBar
    }
    
    // vt dashboard as container
    var dashBoard: Dashboard {
        return self.tabBarController as! Dashboard
    }
    
    // MARK: - Show Activity View
    func showActivityView(_ style: UIActivityIndicatorViewStyle) {
        self.activityView = UIActivityIndicatorView()
        self.activityView?.frame = self.view.frame
        self.activityView?.activityIndicatorViewStyle = style
        self.activityView?.hidesWhenStopped = true
        self.activityView?.startAnimating()
        self.view.addSubview(self.activityView!)
    }
    
    // MARK: - Remove Activity View
    func hideActivityView() {
        self.activityView?.stopAnimating()
    }
    
}
