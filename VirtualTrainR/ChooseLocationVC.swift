//
//  ChooseLocationVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-08-08.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class ChooseLocationVC: VCAssets, CLLocationManagerDelegate {
    
    // View Properties
//    var locationSC: UISearchController!
    var googleMap: GMSMapView!
    var googleMarker: GMSMarker!
    
    // search button
    var searchBtn: UIButton!
    
    // save button
    var saveButton: UIButton?
    
    // dismiss button
    var closeBtn: UIButton!
    
    // location manager
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D? = nil
    
    // location name
    var searchedLocationName: String?
    
    // current session info
    var session: Session?
    
    // selected meetup location
    var selectedMeetUp: SelectedMeetUpLocation?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        // Search Controller
        let resultsUpdater = SearchResultsTableVC()
        resultsUpdater.searching = Searching.meetup
        
        locationSC = UISearchController(searchResultsController: resultsUpdater)
        locationSC?.searchResultsUpdater = resultsUpdater
        
        let searchBar = locationSC?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search and select a meetup point"
        
        locationSC?.hidesNavigationBarDuringPresentation = true
        locationSC?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        searchBar?.backgroundColor = UIColor.black
        */
        
        // set location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // update UI and user location
        locationManager.startUpdatingLocation()
        
        // close button
        closeBtn = UIButton(type: .system)
        closeBtn.setImage(#imageLiteral(resourceName: "cancel_button.png"), for: .normal)
        closeBtn.addTarget(self, action: #selector(self.closeBtnFunction), for: .touchUpInside)
        self.view.addSubview(closeBtn)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        closeBtn.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        closeBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.08).isActive = true
        closeBtn.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.08).isActive = true
        
        // search button
        searchBtn = UIButton(type: .system)
        searchBtn.setImage(#imageLiteral(resourceName: "discover_ic.png"), for: .normal)
        searchBtn.addTarget(self, action: #selector(self.searchButtonFunction), for: .touchUpInside)
        self.view.addSubview(searchBtn)
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        searchBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        searchBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        searchBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.08).isActive = true
        searchBtn.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.08).isActive = true
        
        // save button
        saveButton = UIButton(type: .system)
        saveButton?.setTitle("Save", for: .normal)
        saveButton?.addTarget(self, action: #selector(self.saveBtnFunction), for: .touchUpInside)
        saveButton?.isUserInteractionEnabled = false
        saveButton?.alpha = 0.0
        self.view.addSubview(saveButton!)
        saveButton?.translatesAutoresizingMaskIntoConstraints = false
        saveButton?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        saveButton?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20).isActive = true
        saveButton?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.20).isActive = true
        saveButton?.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.20).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
    }
    
    // MARK: - CLLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = self.locationManager.location?.coordinate
        self.locationManager.stopUpdatingLocation()
        
        let geoCoder = GMSGeocoder()
        let location = CLLocation(latitude: (self.currentLocation?.latitude)!, longitude: (self.currentLocation?.longitude)!)
        
        geoCoder.reverseGeocodeCoordinate(self.currentLocation!) { (response, error) in
            
            let gmsAddress = response?.firstResult()
            
            /*
//            let currentLocation = Location(locationName: "", postalCode: "")
            
            if let locationName = gmsAddress?.thoroughfare {
                currentLocation.locationName = locationName
            }
            if let postalCode = gmsAddress?.postalCode {
                currentLocation.postalCode = postalCode
            }
            
//            self.currentLocation = currentLocation
            */
            
            self.searchedLocationName = gmsAddress?.thoroughfare
            print(self.searchedLocationName)
            
            self.googleMarker = GMSMarker()
            self.googleMarker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//            self.googleMarker.title = self.currentLocation?.locationName
//            self.googleMarker.snippet = self.currentLocation?.postalCode
            
            let camera = GMSCameraPosition.camera(withTarget: self.currentLocation!, zoom: 17.5)
            let gMapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            
            self.googleMarker.map = gMapView
            self.googleMap = gMapView
            
            self.saveButton?.isUserInteractionEnabled = true
            self.saveButton?.alpha = 1.0
            
            self.view.addSubview(self.googleMap)
//            self.view.addSubview(self.searchButton!)
//            self.view.bringSubview(toFront: self.backBtn)
            self.view.bringSubview(toFront: self.closeBtn)
            self.view.bringSubview(toFront: self.searchBtn)
            self.view.bringSubview(toFront: self.saveButton!)
        }
    }
    
    // MARK: - Close Btn Function
    func closeBtnFunction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Search Button Function
    func searchButtonFunction() {
        let autoComplete = GMSAutocompleteViewController()
        autoComplete.delegate = self
        autoComplete.autocompleteBounds = GMSCoordinateBounds(coordinate: self.currentLocation!, coordinate: self.currentLocation!)
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        autoComplete.autocompleteFilter = filter
        self.present(autoComplete, animated: true, completion: nil)
    }
    
    // MARK: - Save Button Function
    func saveBtnFunction() {
        // add most recently searched location name to session
        session?.location = self.searchedLocationName
        self.selectedMeetUp?.appointmentSent(session: self.session!)
        self.closeBtnFunction()
    }
}

extension ChooseLocationVC: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        dismiss(animated: true) {
            
            let coordinates = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
            let cameraUpdate = GMSCameraUpdate.setTarget(coordinates, zoom: 17.5)
            
            self.googleMap?.animate(with: cameraUpdate)
            
            self.googleMarker?.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            
            let geocoder = GMSGeocoder()
            
            geocoder.reverseGeocodeCoordinate(place.coordinate, completionHandler: { (response, error) in
                if error == nil {
                    let gmsAddress = response?.firstResult()
                    self.googleMarker.title = gmsAddress?.thoroughfare
                    
                    self.searchedLocationName = gmsAddress?.thoroughfare
//                    self.marker?.snippet = gmsAddress?.postalCode
                    
//                    self.saveButton?.animateViewToCoordinates(newX: self.view.center.x - ((self.view.frame.width*0.6)/2), newY: (self.view.frame.height * 0.75) - ((self.view.frame.height * 0.10)/2))
                    self.saveButton?.isUserInteractionEnabled = true
                    
                    self.saveButton?.alpha = 1.0
                    
//                    let location = Location(locationName: (gmsAddress?.thoroughfare)!, postalCode: (gmsAddress?.postalCode)!)
                    
//                    self.currentLocation = location
                }
                else {
                    // error
                }
            })
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
