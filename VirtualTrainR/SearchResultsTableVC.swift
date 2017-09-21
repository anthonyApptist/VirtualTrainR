//
//  SearchResultsTableVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-08.
//  Copyright © 2017 Apptist. All rights reserved.
//

enum Searching {
    case meetup
}

import Foundation
import GooglePlaces

class SearchResultsTableVC: UITableViewController {
    
    var searching: Searching?
    
    var allLocations: [String]?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Table View DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searching! {
        case .meetup:
            return (allLocations?.count)!
        }
    }
    
    // MARK: - Filter Search Query
    func filterContentForSearchText(searchText: String) {
        if searching == Searching.meetup {
            GMSPlacesClient.shared().autocompleteQuery(searchText, bounds: nil, filter: nil, callback: { (results, error) in
                self.allLocations?.removeAll()
                if results == nil {
                    return
                }
                for result in results! {
                    if let results = result as? GMSAutocompletePrediction { // GMSAutocompletePrediction
                        self.allLocations?.append(results.attributedFullText.string)
                    }
                    self.tableView.reloadData()
                }
            })
        }
    }
    
}

extension SearchResultsTableVC: UISearchResultsUpdating {
    // Search results updater
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!.lowercased())
    }
}
