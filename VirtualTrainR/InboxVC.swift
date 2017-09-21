//
//  InboxVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-05.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

// temporarily the payment history

class InboxVC: VCAssets, UITableViewDelegate, UITableViewDataSource {
    
    // View Properties
    var comingSoonLbl: UILabel!
    var inboxTableView: UITableView!
    
    // vt inbox
    var vtInbox: VTInbox?
    
    // model, accepted sessions for pay
    var acceptedSessions: [Session]? = []
    
    // Init
    init(vtInbox: VTInbox) {
        super.init(nibName: nil, bundle: nil)
        
        self.vtInbox = vtInbox
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        if self.vtInbox?.portal == Portals.trainer {
            // coming soon label
            comingSoonLbl = UILabel()
            comingSoonLbl.textAlignment = .center
            comingSoonLbl.adjustsFontSizeToFitWidth = true
            comingSoonLbl.textColor = UIColor.black
            comingSoonLbl.text = "Coming Soon!"
            self.view.addSubview(comingSoonLbl)
            comingSoonLbl.translatesAutoresizingMaskIntoConstraints = false
            comingSoonLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            comingSoonLbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            comingSoonLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            comingSoonLbl.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        }
        else {
            inboxTableView = UITableView()
            inboxTableView.register(InboxCell.self, forCellReuseIdentifier: "inboxCell")
            inboxTableView.dataSource = self
            inboxTableView.delegate = self
            self.view.addSubview(inboxTableView)
            inboxTableView.translatesAutoresizingMaskIntoConstraints = false
            inboxTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            inboxTableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
            inboxTableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
            inboxTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        // reset potential badge value
        self.tabBarItem.badgeValue = nil
        
        // data
        self.vtInbox?.inboxUpdate = self
        self.vtInbox?.getInbox()
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // present apple pay view controller with session
        let session = self.acceptedSessions?[indexPath.row]
        let applePayVC = ApplePayVC()
        applePayVC.session = session
        self.tabBarController?.present(applePayVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (acceptedSessions?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inboxCell", for: indexPath) as! InboxCell
        let session = self.acceptedSessions?[indexPath.row]
        cell.nameLbl.text = session?.trainerName
        cell.timeLbl.text = session?.startTime
        cell.dateLbl.text = session?.date
        cell.locationLbl.text = session?.location
        if (session?.paid)! {
            cell.clickToPay.text = "PAID"
        }
        return cell
    }
}

extension InboxVC: InboxUpdate {
    // update inbox list
    func updateInboxList(session: [Session]) {
        self.acceptedSessions = session
        self.inboxTableView.reloadData()
    }
}
