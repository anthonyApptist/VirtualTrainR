//
//  DiscoverVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-05.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

protocol StartScheduling {
    func selectedBook(trainer: Trainer)
}

protocol CreatedSession {
    func presentMeetupLocation(session: Session)
}

protocol SelectedMeetUpLocation {
    func appointmentSent(session: Session)
}

class DiscoverVC: VCAssets, UITableViewDelegate, UITableViewDataSource {
    
    // discover
    var vtDiscover: VTDiscover?
    
    // table view of trainers
    var peopleListTableView: UITableView!
    
    // trainers or clients
    var allTrainers: [Trainer]? = []
    var allClients: [Client]? = []
    
    // Init
    init(vtDiscover: VTDiscover) {
        super.init(nibName: nil, bundle: nil)
        
        self.vtDiscover = vtDiscover
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        // table view of trainers
        peopleListTableView = UITableView()
        peopleListTableView.register(TrainerCell.self, forCellReuseIdentifier: "trainers")
        peopleListTableView.register(ClientCell.self, forCellReuseIdentifier: "clients")
        peopleListTableView.dataSource = self
        peopleListTableView.delegate = self
        self.view.addSubview(peopleListTableView)
        peopleListTableView.translatesAutoresizingMaskIntoConstraints = false
        peopleListTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        peopleListTableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        peopleListTableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
        peopleListTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        if self.vtDiscover?.portal == Portals.client {
            // navigation bar item for map
            let discoverMapBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "discover_location_ic.png"), style: .done, target: self, action: #selector(presentGoogleMap)) // discover_location_ic.png
            discoverMapBtn.tintColor = UIColor.white
            self.navigationItem.setRightBarButtonItems([discoverMapBtn], animated: true)
        }
        
        // set discover delegate
        self.vtDiscover?.updateDiscoverDelegate = self
        
        self.vtDiscover?.startDiscovering()
    }
        
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // present profile view 
        if self.vtDiscover?.portal == Portals.client {
            let trainer = self.allTrainers?[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            profileVC.profile = UserType.discoverTrainer // discover screen clicked on trainer
            // set profile vc trainer
            profileVC.discoveredTrainer = trainer
            profileVC.startScheduling = self
            self.tabBarController?.present(profileVC, animated: true, completion: nil)
        }
        if self.vtDiscover?.portal == Portals.trainer {
            let client = self.allClients?[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            profileVC.profile = UserType.discoverClient // discover screen clicked on trainer
            // set profile vc client
            profileVC.discoveredClient = client
            self.tabBarController?.present(profileVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vtDiscover?.portal == Portals.client {
            return (self.allTrainers?.count)!
        }
        if vtDiscover?.portal == Portals.client {
            return (self.allClients?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.vtDiscover?.portal == Portals.client {
            let cell = tableView.dequeueReusableCell(withIdentifier: "trainers", for: indexPath) as! TrainerCell
            let trainer = self.allTrainers?[indexPath.row]
            cell.nameLbl.text = (trainer?.basicInfo?.firstName)! + " " + (trainer?.basicInfo?.lastname)!
            cell.locationLbl.text = trainer?.email
            // check for photo
            if let imageString = trainer?.basicInfo?.profilePicture {
                cell.trainerImageView.image = self.urlStringToImage(urlString: imageString)
            }
            else {
                cell.trainerImageView.image = defaultProfileImg
            }
//            cell.schedulingDelegate = self
            return cell
        }
        if self.vtDiscover?.portal == Portals.trainer {
            let cell = tableView.dequeueReusableCell(withIdentifier: "clients", for: indexPath) as! ClientCell
            let client = self.allClients?[indexPath.row]
            cell.nameLbl.text = (client?.basicInfo?.firstName)! + " " + (client?.basicInfo?.lastname)!
            cell.locationLbl.text = client?.email
            // check for photo
            if let imageString = client?.basicInfo?.profilePicture {
                cell.clientImageView.image = self.urlStringToImage(urlString: imageString)
            }
            else {
                cell.clientImageView.image = defaultProfileImg
            }
//            cell.schedulingDelegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Go to Apple Map
    func presentGoogleMap() {
        let portal = self.dashBoard.vtDashboard?.account
        let map = Map(account: portal!)
        let appleMap = AppleMaps(map: map)
        self.navigationController?.pushViewController(appleMap, animated: true)
    }
}

extension DiscoverVC: CreatedSession, UpdateDiscoverList, SelectedMeetUpLocation, StartScheduling {
    // MARK: - Update Discover List
    func updateTrainerList(_ trainers: [Trainer]) {
        self.allTrainers = trainers
        self.peopleListTableView.reloadData()
    }
    
    func updateClientList(_ clients: [Client]) {
        self.allClients = clients
        self.peopleListTableView.reloadData()
    }
    
    // MARk: - Present Scheduling VC
    func selectedBook(trainer: Trainer) {
        let chooseTime = ChooseTimeVC()
        chooseTime.created = self
        chooseTime.selectedTrainer = trainer
        self.tabBarController?.present(chooseTime, animated: true, completion: nil)
    }
    
    // MARK: - Created Session Time and Date
    func presentMeetupLocation(session: Session) {
        // select location vc
        let chooseLocationVC = ChooseLocationVC()
        chooseLocationVC.session = session
        chooseLocationVC.selectedMeetUp = self
        self.tabBarController?.present(chooseLocationVC, animated: true, completion: nil)
    }
    
    // MARK: - Selected Meetup Location
    func appointmentSent(session: Session) {
        // save session to database
        DataService.instance.saveTrainingSession(session)
        self.createAlertController(title: "Appointment sent to trainer", message: "Check the inbox tab if accepted and click to pay with Apple Pay", actionTitle: "OK", actionStyle: .cancel)
    }

}
