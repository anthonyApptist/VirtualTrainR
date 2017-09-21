//
//  Dashboard.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-03.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class Dashboard: UITabBarController {
    
    // tab bar icon Images
    let calenderIcon = #imageLiteral(resourceName: "calendar_ic.png") // calendar_ic.png
    let discoverIcon = #imageLiteral(resourceName: "discover_ic.png") // discover_ic.png
    let inboxIcon = #imageLiteral(resourceName: "inbox_ic.png") // inbox_ic.png
    let profileIcon = #imageLiteral(resourceName: "profile_ic.png") // profile_ic.png
    
    // View Controllers
    var calendarVC: CalendarVC!
    var discoverVC: DiscoverVC!
    var inboxVC: InboxVC!
    var profileVC: ProfileVC!
    
    // dashboard
    var vtDashboard: VTDashboard?

    // Init
    init(vtDashboard: VTDashboard) {
        self.vtDashboard = vtDashboard
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTabBarForClient()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        self.vtDashboard?.portalDelegate = self
    }
    
    // MARK: - Set View Controllers for Client
    func setTabBarForClient() {
        print(self.vtDashboard?.account!)
        
        // tab bar view controllers icons
        let calendarTabBarIcon = UITabBarItem(title: TabBarName.calendar.rawValue, image: calenderIcon, tag: 0) // calendar
        let discoverTabBarIcon = UITabBarItem(title: TabBarName.discover.rawValue, image: discoverIcon, tag: 1)
        let inboxTabBarIcon = UITabBarItem(title: TabBarName.inbox.rawValue, image: inboxIcon, tag: 2)
        let profileTabBarIcon = UITabBarItem(title: TabBarName.profile.rawValue, image: profileIcon, tag: 3)
        
        // tab bar view controllers
        let vtCalendar = VTCalendar(portal: self.vtDashboard!.account!)
        calendarVC = CalendarVC(calendar: vtCalendar)
        calendarVC.tabBarItem = calendarTabBarIcon
        
        let vtDiscover = VTDiscover(portal: self.vtDashboard!.account!)
        discoverVC = DiscoverVC(vtDiscover: vtDiscover)
        discoverVC.tabBarItem = discoverTabBarIcon
        
        let vtInbox = VTInbox(portal: self.vtDashboard!.account!)
        inboxVC = InboxVC(vtInbox: vtInbox)
        inboxVC.tabBarItem = inboxTabBarIcon
        
        // storyboard instantiate profile vc
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        profileVC.tabBarItem = profileTabBarIcon
        
        // set profile vc load profile variable
        profileVC.profile = UserType.client
        
        // embed in nav controller
        let calendarNC = VTNavigation(rootViewController: calendarVC)
        calendarNC.navigationBar.topItem?.title = TabBarName.calendar.rawValue
        
        let discoverNC = VTNavigation(rootViewController: discoverVC)
        discoverNC.navigationBar.topItem?.title = TabBarName.discover.rawValue
        
        let inboxNC = VTNavigation(rootViewController: inboxVC)
        inboxNC.navigationBar.topItem?.title = TabBarName.inbox.rawValue
        
        let profileNC = VTNavigation(rootViewController: profileVC)
        profileNC.navigationBar.topItem?.title = TabBarName.profile.rawValue
        
        let tabBarVCs = [calendarNC, discoverNC, inboxNC, profileNC]
        
        // set delegate for client inbox
        self.vtDashboard?.clientInbox = self
        
        // create observer
        self.vtDashboard?.createClientInboxCalendarObserver()
        
        // set view controllers for a client
        self.setViewControllers(tabBarVCs, animated: true)
    }
    
    // MARK: - Set View Controllers for Trainer
    func setTabBarForTrainer() {
        print(self.vtDashboard?.account!)
        
        // tab bar view controllers icons
        let calendarTabBarIcon = UITabBarItem(title: TabBarName.calendar.rawValue, image: calenderIcon, tag: 0) // calendar
        let discoverTabBarIcon = UITabBarItem(title: TabBarName.discover.rawValue, image: discoverIcon, tag: 1)
        let inboxTabBarIcon = UITabBarItem(title: TabBarName.inbox.rawValue, image: inboxIcon, tag: 2)
        let profileTabBarIcon = UITabBarItem(title: TabBarName.profile.rawValue, image: profileIcon, tag: 3)
        
        // tab bar view controllers
        let vtCalendar = VTCalendar(portal: self.vtDashboard!.account!)
        calendarVC = CalendarVC(calendar: vtCalendar)
        calendarVC.tabBarItem = calendarTabBarIcon
        
        let vtDiscover = VTDiscover(portal: self.vtDashboard!.account!)
        discoverVC = DiscoverVC(vtDiscover: vtDiscover)
        discoverVC.tabBarItem = discoverTabBarIcon
        
        let vtInbox = VTInbox(portal: self.vtDashboard!.account!)
        inboxVC = InboxVC(vtInbox: vtInbox)
        inboxVC.tabBarItem = inboxTabBarIcon
        
        // storyboard instantiate profile vc
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        profileVC.tabBarItem = profileTabBarIcon
        
        // set profile vc load profile variable
        profileVC.profile = UserType.trainer
        
        // embed in nav controller
        let calendarNC = VTNavigation(rootViewController: calendarVC)
        calendarNC.navigationBar.topItem?.title = TabBarName.calendar.rawValue
        
        let discoverNC = VTNavigation(rootViewController: discoverVC)
        discoverNC.navigationBar.topItem?.title = TabBarName.discover.rawValue
        
        let inboxNC = VTNavigation(rootViewController: inboxVC)
        inboxNC.navigationBar.topItem?.title = TabBarName.inbox.rawValue
        
        let profileNC = VTNavigation(rootViewController: profileVC)
        profileNC.navigationBar.topItem?.title = TabBarName.profile.rawValue
        
        let tabBarVCs = [calendarNC, discoverNC, inboxNC, profileNC]
        
        // has a trainer profile already
        if AuthService.instance.checkTrainerProfile() {
            print("trainer profile exists")
            
            // create observer
            self.vtDashboard?.createTrainerCalendarObserver()
        }
        else {
            // create a trainer profile on database
            DataService.instance.saveNewTrainer()
            
            DataService.instance.newTrainerDelegate = self
            
            // make alert trainer profile now discoverable
            self.createAlertController(title: "Trainer account created", message: "it is now discoverable", actionTitle: "OK", actionStyle: .cancel)
        }
        
        // set view controllers for a trainer
        self.setViewControllers(tabBarVCs, animated: true)
        
    }

}

extension Dashboard: PortalSwitch, CompleteNewTrainer, TrainerCalendarTab, ClientInboxTab {
    // MARK: - Portal Switch
    func switchToClientPortal() { // from trainer portal
        // clear observers
        self.vtDashboard?.clearExistingObservers()
        
        // set dashboard account to client
        self.vtDashboard?.account = Portals.client
        self.vtDashboard?.clientInbox = self
        
        // stop location manager
        self.vtDashboard?.stopLocationManager()
        
        // set view controllers
        self.setTabBarForClient()
    }
    
    func switchToTrainerPortal() { // from client portal
        self.vtDashboard?.clearExistingObservers()
        
        // set dashboard account to trainer
        self.vtDashboard?.account = Portals.trainer
        self.vtDashboard?.trainerCalendar = self
        
        // track location
        self.vtDashboard?.startLocationManager()
        
        // set view controllers
        self.setTabBarForTrainer()
    }
    
    // MARK: - New Trainer
    func didCreateNewTrainer() {
        self.vtDashboard?.createTrainerCalendarObserver()
    }
    
    // MARK: - Client Inbox
    func didReceiveResponse() { // receive response to appointment sent to trainer
        self.inboxVC.tabBarItem.badgeColor = UIColor.red
        self.inboxVC.tabBarItem.badgeValue = "!"
    }
    
    // MARK: - Trainer Calendar
    func didReceiveNewRequest() { // receive request for appointment
        // receive a new appointment request
        self.calendarVC.tabBarItem.badgeColor = UIColor.red
        self.calendarVC.tabBarItem.badgeValue = "!"
    }
}
