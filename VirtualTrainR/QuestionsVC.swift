//
//  QuestionsTableVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-15.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit

class QuestionsTableVC: RegisterVC, UITableViewDataSource, UITableViewDelegate {
    
    // view model
    var tableView: UITableView!
    
    // data model
    var activities = ["Yoga", "Body Building", "Endurance Training", "Weight Loss", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.vtlogo.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.71).isActive = true
        
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
    }
    
    // MARK: - Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }

}

class SelectionCells: UITableViewCell {
    
    
    
}
