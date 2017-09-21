//
//  Map.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-06.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation
import MapKit
import Pulsator
import SVPulsingAnnotationView

// Map Protocol
protocol Discovering {
    func updating()
    func initialLocationUpdated(location: CLLocationCoordinate2D)
    func currentLocationUpdated(location: CLLocationCoordinate2D)
    func loaded(trainerLocations: [MKAnnotation])
    func remove(trainerLocations: [MKAnnotation])
    func errorGettingTrainers()
}

class Map: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // user pin
    let pinImage = #imageLiteral(resourceName: "location_ic.png") // location_ic.png
    let indicator = #imageLiteral(resourceName: "slider_thumb.png") // slider_thumb.png
    
    // current portal
    var account: Portals?
    
    // delegate
    var mapDelegate: Discovering?
    
    // location manager
    var locationManager = CLLocationManager()
    
    // location variables
    var currentLocation: CLLocationCoordinate2D?
    var initalLocation: Bool?
    
    // trainers (from database)
    var trainers: [Trainer]?
    var trainerLocations: [MKAnnotation]?
    
    // database ref to online trainers node
    var ref: DatabaseReference?
    
    // Init
    init(account: Portals) {
        super.init()
        
        self.account = account
        self.locationManager.delegate = self
    }
    
    // get necessary info for google map
    func getInfo() {
        switch account! {
        case .client:
            self.mapDelegate?.updating()
            self.startUpdating() // get current location
            self.getOnlineTrainers() // get trainer locations
            break
        case .trainer:
            // get current location
            self.mapDelegate?.updating()
            self.startUpdating()
            break
        }
    }
    
    // MARK: - Location Start Update (Location Manager)
    func startUpdating() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        self.initalLocation = true
    }
    
    // MARK: - CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.initalLocation! {
            self.currentLocation = manager.location?.coordinate
            self.mapDelegate?.initialLocationUpdated(location: self.currentLocation!)
            self.initalLocation = false
        }
        else {
            self.currentLocation = manager.location?.coordinate
            self.mapDelegate?.currentLocationUpdated(location: self.currentLocation!)
        }
    }
    
    // MARK: MapView Delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "user")
            annotationView.image = pinImage
            self.getOnlineTrainers()
            return annotationView
        }
        else {
            let annotationView = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: "trainer")
            /*
            let pulsator = Pulsator()
            pulsator.radius = 100.0
            annotationView.layer.insertSublayer(pulsator, below: nil)
            pulsator.start()
            let pulse = LFTPulseAnimation(radius: 100.0, position: annotationView.center)
            annotationView.layer.addSublayer(pulse)
             */
            return annotationView
        }
    }
    
    // remove firebase observers
    func removeRefObservers() {
        self.ref?.removeAllObservers()
    }
    
    // MARK: - Online Trainers List
    func getOnlineTrainers() {
        self.ref = DataService.instance.onlineRef
        
        self.trainers = []
        self.trainerLocations = []
        
        self.ref?.observe(.value, with: { (snapshot) in
            self.mapDelegate?.remove(trainerLocations: self.trainerLocations!)
            
            self.trainerLocations?.removeAll()
            
            for trainer in snapshot.children.allObjects {
                let aTrainer = Trainer() // trainer
                
                let trainerProfile = trainer as! DataSnapshot
                let trainerData = trainerProfile.value as? NSDictionary
                
                let trainerID = trainerProfile.key
                
                aTrainer.uid = trainerID
                
                let firstName = trainerData?["firstName"] as? String
                let lastName = trainerData?["lastName"] as? String
                
                aTrainer.basicInfo?.firstName = firstName
                aTrainer.basicInfo?.lastname = lastName
                
                let latitude = trainerData?["latitude"] as? Double
                let longitude = trainerData?["longitude"] as? Double
                
                let latitudeDegrees = CLLocationDegrees(latitude!)
                let longitudeDegrees = CLLocationDegrees(longitude!)
                
                let coordinates = CLLocationCoordinate2D(latitude: latitudeDegrees, longitude: longitudeDegrees)
                
                aTrainer.currentLocation = coordinates
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates
                
                self.trainerLocations?.append(annotation)
                self.trainers?.append(aTrainer)
            }
            // update on google map
            self.mapDelegate?.loaded(trainerLocations: self.trainerLocations!)
            
        }) { (error) in
            self.mapDelegate?.errorGettingTrainers()
        }
    }
    
    
    
}
