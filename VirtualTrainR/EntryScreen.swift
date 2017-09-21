//
//  EntryScreen.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-14.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import Localize_Swift

/*
 * Splash screen that users first see when they open the app
 * video plays in the background
 */

class EntryScreen: VCAssets {
    
    // splash screen assets
    let splashVideo: URL = Bundle.main.url(forResource: "start_video", withExtension: ".mp4")!
    let sloganText = "GET IN THE SHAPE OF YOUR LIFE"
    
    // view properties
    var vtBtn: VTButton!
    var sloganLbl = UILabel()
    let languageBtn = UIButton()
    let startedBtn = VTButton()
    let loginBtn = VTButton()
    
    // av player
    var playerItem: AVPlayerItem!
    var videoPlayer: AVQueuePlayer!
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // AV Player
        self.videoPlayer = AVQueuePlayer()
        
        let session: NSError! = nil
        let asset: AVAsset! = AVAsset(url: splashVideo)
        playerItem = AVPlayerItem(asset: asset)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(session)
        }
        
        videoPlayer.insert(playerItem, after: nil)
        
        let videoLayer = AVPlayerLayer(player: self.videoPlayer)
        videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        videoLayer.frame = UIScreen.main.bounds
        
        // add video layer to view
        self.view.layer.addSublayer(videoLayer)
        videoPlayer.seek(to: kCMTimeZero)
        videoPlayer.volume = 1.0
        videoPlayer.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        videoPlayer.play()
        
        // blur effect on background
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.effect = blurEffect
        self.view.addSubview(blurEffectView)
        
        // Login button (VT image in center)
        vtBtn = VTButton()
        vtBtn.setImage(#imageLiteral(resourceName: "splash_screen_logo.png"), for: .normal) // splash_screen_logo.png
        vtBtn.isUserInteractionEnabled = false
        self.view.addSubview(vtBtn)
        vtBtn.translatesAutoresizingMaskIntoConstraints = false
        vtBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        vtBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        vtBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        vtBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // slogan under VT button
        sloganLbl.font = self.createFontWithSize(fontName: heavyFont, size: 30)
        self.view.addSubview(sloganLbl)
        sloganLbl.text = sloganText
        sloganLbl.textAlignment = .center
        sloganLbl.textColor = UIColor.white
        sloganLbl.numberOfLines = 0
        sloganLbl.translatesAutoresizingMaskIntoConstraints = false
        sloganLbl.centerXAnchor.constraint(equalTo: vtBtn.centerXAnchor).isActive = true
        sloganLbl.topAnchor.constraint(equalTo: vtBtn.bottomAnchor).isActive = true
        sloganLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        sloganLbl.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        
        /*
        // Set Language
        Localize.setCurrentLanguage("en")
        setText()
        
        self.view.addSubview(languageBtn)
        languageBtn.translatesAutoresizingMaskIntoConstraints = false
        languageBtn.titleLabel?.textAlignment = .right
        languageBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0)
        languageBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        languageBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        languageBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        languageBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        languageBtn.isHidden = true 
        languageBtn.setTitleColor(UIColor.white, for: .normal)
        languageBtn.titleLabel?.font = UIFont(name: "SFUIText-Light", size: 17)
        languageBtn.addTarget(self, action: #selector(languageBtnPressed), for: .touchUpInside)
         
         // get started btn
         startedBtn.setBackgroundImage(kSplashScreenFill, for: .normal)
         startedBtn.setTitle("Let's get started", for: .normal)
         startedBtn.setTitleColor(UIColor.white, for: .normal)
         startedBtn.titleLabel?.font = self.createFontWithSize(fontName: subtitleFont, size: 16.0)
         startedBtn.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
         self.view.addSubview(startedBtn)
         startedBtn.translatesAutoresizingMaskIntoConstraints = false
         startedBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
         startedBtn.topAnchor.constraint(equalTo: sloganLbl.bottomAnchor).isActive = true
         startedBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
         startedBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
         */
        
        // login btn
        loginBtn.setBackgroundImage(kSplashScreenBorder, for: .normal)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.titleLabel?.font = self.createFontWithSize(fontName: subtitleFont, size: 16.0)
        loginBtn.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginBtn.topAnchor.constraint(equalTo: sloganLbl.bottomAnchor, constant: 25).isActive = true
        loginBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        loginBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        // notification for video ended to restart video
        NotificationCenter.default.addObserver(self, selector: #selector(self.videoDidReachEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.videoPlayer.currentItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        videoPlayer.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        videoPlayer.pause()
    }
    
    // Notification Function
    func videoDidReachEnd(_ notification: Notification) {
        videoPlayer.seek(to: kCMTimeZero)
        videoPlayer.play()
    }
    
    func setText() {
        sloganLbl.text = "GET IN THE SHAPE OF YOUR LIFE".localized()
        languageBtn.setTitle("Select Language".localized(), for: .normal)
    }
    
    func languageBtnPressed() {
   //     let vc = AppLanguageVC()
   //     present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Login Btn Function
    func loginPressed() {
        let loginSelection = LoginSelection()
        self.present(loginSelection, animated: true, completion: nil)
    }
    
    /*
    // touch screen to go to register screen (or check user defaults)
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.present(QuestionsButtonVC(), animated: true, completion: nil)
    }
    
    // MARK: - Started Btn Function
    func getStarted() {
        self.toRegisterQuestions()
    }
    */
    
    /*
    func goToAccountSelection() {
        let accountSelection = AccountSelection()
        self.present(accountSelection, animated: true, completion: nil)
    }
    
    // MARK: - To Login Screen
    func goToLogin() {
        let accountSelection = QuestionsButtonVC()
        self.present(accountSelection, animated: true, completion: {
            accountSelection.setTitleString(str: "Login to")
            accountSelection.setTopTitle(str: "Client Account")
            accountSelection.setBottomTitle(str: "Trainer Account")
        })
    }
     
    // MARK: - To Register Questions
    func toRegisterQuestions() {
        let questionBtnVC = QuestionsButtonVC()
        self.present(questionBtnVC, animated: true, completion: {
            questionBtnVC.setTitleString(str: "How can Virtual TrainR assist you?") // set question for view
        })
    }
    */
}
