//
//  CalendarVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-05.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class CalendarVC: VCAssets, UITableViewDelegate, UITableViewDataSource {
    
    // View Properties
    var sessionTableView: UITableView!
    
    // model
    var sessions: [Session]? = []
    
    // vt calendar
    var vtCalendar: VTCalendar?
    
    // Init
    init(calendar: VTCalendar) {
        super.init(nibName: nil, bundle: nil)
        
        self.vtCalendar = calendar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        // table view
        sessionTableView = UITableView()
        sessionTableView.register(SessionCell.self, forCellReuseIdentifier: "session")
        sessionTableView.dataSource = self
        sessionTableView.delegate = self
        self.view.addSubview(sessionTableView)
        sessionTableView.translatesAutoresizingMaskIntoConstraints = false
        sessionTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        sessionTableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        sessionTableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
        sessionTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        self.tabBarItem.badgeValue = nil
        
        self.vtCalendar?.calendarDelegate = self
        self.vtCalendar?.getCalendarInfo()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.vtCalendar?.removeDatabaseObservers()
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.sessions?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "session", for: indexPath) as! SessionCell
        let session = self.sessions?[indexPath.row]
        switch (self.vtCalendar?.portal)! {
        case .client:
            cell.nameLbl.text = session?.trainerName
            cell.timeLbl.text = session?.startTime
            cell.dateLbl.text = session?.date
            cell.locationLbl.text = session?.location
            // remove buttons
            cell.acceptBtn.removeFromSuperview()
            cell.declineBtn.removeFromSuperview()
        case .trainer:
            cell.nameLbl.text = session?.clientName
            cell.timeLbl.text = session?.startTime
            cell.dateLbl.text = session?.date
            cell.locationLbl.text = session?.location
            cell.cellSession = session
            
            // check if session was already accepted
            if (session?.accepted)! {
                cell.acceptBtn.setTitle("Accepted", for: .normal)
                cell.acceptBtn.isUserInteractionEnabled = false
                cell.declineBtn.alpha = 0.1
                cell.declineBtn.isUserInteractionEnabled = false
            }
        }
        return cell
    }
}

extension CalendarVC: CalendarUpdate {
    // update
    func updateSessionList(session: [Session]) {
        self.sessions = session
        self.sessionTableView.reloadData()
    }
}
