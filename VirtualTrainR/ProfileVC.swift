//
//  ProfileSegment.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-20.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

let min_header: CGFloat = 50
let bar_offset: CGFloat = 1

protocol SelectedTrainerToBook {
    func didSelectedBook()
}

class ProfileVC: VCAssets, UIScrollViewDelegate, SubScrollDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    /*
    let tabView = UIView()
    let tabBtn1 = UIButton()
    let tabBtn2 = UIButton()
    let tabBtn3 = UIButton()
    
    let verifiedLbl = UILabel()
    
    // symbols
    let facebookSym = UIImageView()
    let emailSym = UIImageView()
    let phoneSym = UIImageView()
    let googleSym = UIImageView()
    let linkedInSym = UIImageView()
    let cardSym = UIImageView()
     */
    
    // profile view
    var profile: UserType?
    
    // discovered client or trainer passed over to profile segment
    var discoveredTrainer: Trainer?
    var discoveredClient: Client?
    
    // delegate for profile segment
    var startScheduling: StartScheduling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        headerView.layer.zPosition = 1
        containerView.layer.zPosition = 2
        
        /*
        barView.layer.zPosition = 0
        barView.isUserInteractionEnabled = false
        barView.bringSubview(toFront: segmentedControl)
        
        segmentedControl.setEnabled(true, forSegmentAt: 0)
        segmentedControl.setEnabled(true, forSegmentAt: 1)
        segmentedControl.setEnabled(true, forSegmentAt: 2)

        segmentedControl.isEnabledForSegment(at: 0)
        segmentedControl.isEnabledForSegment(at: 1)
        segmentedControl.isEnabledForSegment(at: 2)
        
        self.view.bringSubview(toFront: barView)
        
        tabView.backgroundColor = UIColor.lightGray
        self.view.addSubview(tabView)
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        tabView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        tabView.bottomAnchor.constraint(equalTo: self.segmentedControl.topAnchor, constant: -10).isActive = true
        tabView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        tabBtn1.makeRound()
        self.tabView.addSubview(tabBtn1)
        tabBtn1.translatesAutoresizingMaskIntoConstraints = false
        tabBtn1.leadingAnchor.constraint(equalTo: tabView.leadingAnchor).isActive = true
        tabBtn1.topAnchor.constraint(equalTo: tabView.topAnchor).isActive = true
        tabBtn1.heightAnchor.constraint(equalTo: tabView.heightAnchor, multiplier: 1.0).isActive = true
        tabBtn1.widthAnchor.constraint(equalTo: tabView.widthAnchor, multiplier: 0.333).isActive = true
        tabBtn1.setImage(#imageLiteral(resourceName: "profile_ic_white.png"), for: .normal)
        tabBtn1.addTarget(self, action: #selector(tabBtn1Pressed), for: .touchUpInside)
        
        tabBtn2.makeRound()
        self.tabView.addSubview(tabBtn2)
        tabBtn2.translatesAutoresizingMaskIntoConstraints = false
        tabBtn2.leadingAnchor.constraint(equalTo: tabBtn1.trailingAnchor).isActive = true
        tabBtn2.topAnchor.constraint(equalTo: tabView.topAnchor).isActive = true
        tabBtn2.heightAnchor.constraint(equalTo: tabView.heightAnchor, multiplier: 1.0).isActive = true
        tabBtn2.widthAnchor.constraint(equalTo: tabView.widthAnchor, multiplier: 0.333).isActive = true
        tabBtn2.setImage(#imageLiteral(resourceName: "wallet_ic.png"), for: .normal)
        tabBtn2.addTarget(self, action: #selector(tabBtn2Pressed), for: .touchUpInside)
        
        tabBtn3.makeRound()
        self.tabView.addSubview(tabBtn3)
        tabBtn3.translatesAutoresizingMaskIntoConstraints = false
        tabBtn3.leadingAnchor.constraint(equalTo: tabBtn2.trailingAnchor).isActive = true
        tabBtn3.topAnchor.constraint(equalTo: tabView.topAnchor).isActive = true
        tabBtn3.heightAnchor.constraint(equalTo: tabView.heightAnchor, multiplier: 1.0).isActive = true
        tabBtn3.widthAnchor.constraint(equalTo: tabView.widthAnchor, multiplier: 0.333).isActive = true
        tabBtn3.setImage(#imageLiteral(resourceName: "settings_ic.png"), for: .normal)
        tabBtn3.addTarget(self, action: #selector(tabBtn3Pressed), for: .touchUpInside)
        
        verifiedLbl.font = UIFont(name: "SFUIDisplay-Light", size: 14)
        verifiedLbl.text = "Verified:"
        verifiedLbl.textAlignment = .left
        verifiedLbl.textColor = UIColor.white
        self.view.addSubview(verifiedLbl)
        verifiedLbl.translatesAutoresizingMaskIntoConstraints = false
        verifiedLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        verifiedLbl.bottomAnchor.constraint(equalTo: self.tabView.topAnchor, constant: 5).isActive = true
        verifiedLbl.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 0.1).isActive = true
        verifiedLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0.333).isActive = true 
            
        self.view.addSubview(facebookSym)
        facebookSym.image = #imageLiteral(resourceName: "facebook_verify_ic.png")
        facebookSym.translatesAutoresizingMaskIntoConstraints = false
        facebookSym.leadingAnchor.constraint(equalTo: verifiedLbl.trailingAnchor, constant: 3).isActive = true
        facebookSym.centerYAnchor.constraint(equalTo: verifiedLbl.centerYAnchor).isActive = true
        facebookSym.widthAnchor.constraint(equalToConstant: 20).isActive = true
        facebookSym.heightAnchor.constraint(equalToConstant: 20).isActive = true
        facebookSym.isHidden = false
        
        self.view.addSubview(emailSym)
        emailSym.image = #imageLiteral(resourceName: "email_verify_ic.png")
        emailSym.translatesAutoresizingMaskIntoConstraints = false
        emailSym.leadingAnchor.constraint(equalTo: facebookSym.trailingAnchor, constant: 3).isActive = true
        emailSym.centerYAnchor.constraint(equalTo: verifiedLbl.centerYAnchor).isActive = true
        emailSym.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailSym.heightAnchor.constraint(equalToConstant: 20).isActive = true
        emailSym.isHidden = false
        
        self.view.addSubview(phoneSym)
        phoneSym.image = #imageLiteral(resourceName: "profile_verify_btn")
        phoneSym.translatesAutoresizingMaskIntoConstraints = false
        phoneSym.leadingAnchor.constraint(equalTo: emailSym.trailingAnchor, constant: 3).isActive = true
        phoneSym.centerYAnchor.constraint(equalTo: verifiedLbl.centerYAnchor).isActive = true
        phoneSym.widthAnchor.constraint(equalToConstant: 20).isActive = true
        phoneSym.heightAnchor.constraint(equalToConstant: 20).isActive = true
        phoneSym.isHidden = false
        
        self.view.addSubview(googleSym)
        googleSym.image = #imageLiteral(resourceName: "gmail_verify_ic.png")
        googleSym.translatesAutoresizingMaskIntoConstraints = false
        googleSym.leadingAnchor.constraint(equalTo: phoneSym.trailingAnchor, constant: 3).isActive = true
        googleSym.centerYAnchor.constraint(equalTo: verifiedLbl.centerYAnchor).isActive = true
        googleSym.widthAnchor.constraint(equalToConstant: 20).isActive = true
        googleSym.heightAnchor.constraint(equalToConstant: 20).isActive = true
        googleSym.isHidden = false
        
        self.view.addSubview(linkedInSym)
        linkedInSym.image = #imageLiteral(resourceName: "gmail_verify_ic.png")
        linkedInSym.translatesAutoresizingMaskIntoConstraints = false
        linkedInSym.leadingAnchor.constraint(equalTo: googleSym.trailingAnchor, constant: 3).isActive = true
        linkedInSym.centerYAnchor.constraint(equalTo: verifiedLbl.centerYAnchor).isActive = true
        linkedInSym.widthAnchor.constraint(equalToConstant: 20).isActive = true
        linkedInSym.heightAnchor.constraint(equalToConstant: 20).isActive = true
        */
    }
    
    /*
    func tabBtn1Pressed() {
        
        segmentedControl.isHidden = false
        
        if !tabBtn1.isSelected {
            tabBtn1.backgroundColor = UIColor.white
            tabBtn1.setImage(#imageLiteral(resourceName: "profile_ic.png"), for: .normal)
            tabBtn1.isSelected = true
            
            segmentedControl.selectedSegmentIndex = 0
            
            if segmentedControl.numberOfSegments == 2 {
                
                segmentedControl.insertSegment(withTitle: "Favourites", at: 2, animated: true)
                
            }
            
            segmentedControl.setTitle("Profile", forSegmentAt: 0)
            segmentedControl.setTitle("My Trainers", forSegmentAt: 1)
            segmentedControl.setTitle("Favourites", forSegmentAt: 2)
        }
        
        if tabBtn2.isSelected {
            tabBtn2.backgroundColor = UIColor.lightGray
            tabBtn2.setImage(#imageLiteral(resourceName: "wallet_ic.png"), for: .normal)
            tabBtn2.isSelected = false
        }
        
        if tabBtn3.isSelected {
            tabBtn3.backgroundColor = UIColor.lightGray
            tabBtn3.setImage(#imageLiteral(resourceName: "settings_ic.png"), for: .normal)
            tabBtn3.isSelected = false
        }
        indexChanged()
    }
    
    func tabBtn2Pressed() {
        segmentedControl.isHidden = false
        
        if !tabBtn2.isSelected {
            tabBtn2.backgroundColor = UIColor.white
            tabBtn2.setImage(#imageLiteral(resourceName: "wallet_2_ic"), for: .normal)
            tabBtn2.isSelected = true
            
            segmentedControl.selectedSegmentIndex = 0
            
            segmentedControl.setTitle("Transaction History", forSegmentAt: 0)
            segmentedControl.setTitle("Payment Method", forSegmentAt: 1)
            
            if segmentedControl.numberOfSegments > 2 {
                segmentedControl.removeSegment(at: 2, animated: true)
            }
        }
        
        if tabBtn1.isSelected {
            tabBtn1.backgroundColor = UIColor.lightGray
            tabBtn1.setImage(#imageLiteral(resourceName: "profile_ic_white.png"), for: .normal)
            tabBtn1.isSelected = false
        }
        
        if tabBtn3.isSelected {
            tabBtn3.backgroundColor = UIColor.lightGray
            tabBtn3.setImage(#imageLiteral(resourceName: "settings_ic.png"), for: .normal)
            tabBtn3.isSelected = false
        }
        
        indexChanged()
    }
    
    func tabBtn3Pressed() {
        segmentedControl.isHidden = false
        
        if !tabBtn3.isSelected {
            tabBtn3.backgroundColor = UIColor.white
            tabBtn3.setImage(#imageLiteral(resourceName: "settings_ic.png"), for: .normal)
            tabBtn3.isSelected = true
            
            segmentedControl.selectedSegmentIndex = 0
            
            segmentedControl.setTitle("Settings", forSegmentAt: 0)
            segmentedControl.setTitle("Verification", forSegmentAt: 1)
            
            if segmentedControl.numberOfSegments > 2 {
                segmentedControl.removeSegment(at: 2, animated: true)
            }
        }
        if tabBtn2.isSelected {
            tabBtn2.backgroundColor = UIColor.lightGray
            tabBtn2.setImage(#imageLiteral(resourceName: "wallet_ic.png"), for: .normal)
            tabBtn2.isSelected = false
        }
        if tabBtn1.isSelected {
            tabBtn1.backgroundColor = UIColor.lightGray
            tabBtn1.setImage(#imageLiteral(resourceName: "profile_ic_white.png"), for: .normal)
            tabBtn1.isSelected = false
        }
        indexChanged()

    }

    func indexChanged() {
        
        if tabBtn1.isSelected {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                print("profile tab")
            case 1:
                print("my trainers")
            case 2:
                print("favourites")
            default:
                break
            }
        }
        
        if tabBtn2.isSelected {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                print("transaction history")
            case 1:
                print("payment method")
            default:
                break
            }
        }
        
        if tabBtn3.isSelected {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                break
            case 1:
                print("settings")
            default:
                break
            }
        }
    }
    */
    
    // MARK: - TableViewDidScroll
    func tableViewScrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset < 0 {
            var headerTransform = CATransform3DIdentity
            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            headerView.layer.transform = headerTransform
//            tabView.layer.transform = headerTransform
        } else {
            var headerTransform = CATransform3DIdentity
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-(headerView.bounds.height-min_header), -offset), 0)
            headerView.layer.transform = headerTransform
//            tabView.layer.transform = headerTransform
        }
        
        if (headerView.bounds.height-min_header) < offset {
            headerView.layer.zPosition = 3
        } else {
            headerView.layer.zPosition = 0
        }
        
        if (headerView.bounds.height-min_header+bar_offset) < offset {
            barView.layer.zPosition = 3
        } else {
            barView.layer.zPosition = 1
        }
        
        var barTransform = CATransform3DIdentity
        barTransform = CATransform3DTranslate(barTransform, 0, max(-(headerView.bounds.height*1.3-min_header+bar_offset), -offset), 0)
        barView.layer.transform = barTransform
    }
    
    // MARK: - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedProfile" {
            let profileSegment = segue.destination as! ProfileSegment
            let loadProfile = VTLoadProfile(type: self.profile!)
            print("Profile is set to \(self.profile!)")
            profileSegment.loadProfile = loadProfile
            profileSegment.loadProfile?.loadInfo = profileSegment
            profileSegment.scrollDelegate = self
            
            // set conditions for discovering and setting the model directly
            if self.profile == UserType.discoverTrainer {
                profileSegment.trainer = self.discoveredTrainer
                profileSegment.startBooking = self
            }
            if self.profile == UserType.discoverClient {
                profileSegment.client = self.discoveredClient
            }
        }
    }
}

extension ProfileVC: SelectedTrainerToBook {
    func didSelectedBook() {
        print(self.discoveredTrainer)
        self.dismiss(animated: true) { 
            self.startScheduling?.selectedBook(trainer: self.discoveredTrainer!)
        }
    }
}

