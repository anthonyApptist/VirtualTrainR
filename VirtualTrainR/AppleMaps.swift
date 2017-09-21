//
//  AppleMaps.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-13.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class AppleMaps: VCAssets, Discovering {
    
    // Properties
    var map: Map?
    
    // View Properties
    var appleMapView: MKMapView!
    var userAnnotationView: MKAnnotationView!
    
    // Init
    init(map: Map) {
        super.init(nibName: nil, bundle: nil)
        self.map = map
        self.map?.mapDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.map?.getInfo()
    }
    
    // MARK: - Create Map View
    func createMapView() {
        
        // apple map view
        appleMapView = MKMapView()
        appleMapView.delegate = self.map
        appleMapView.showsUserLocation = true
        appleMapView.userTrackingMode = .follow
        self.view.addSubview(appleMapView)
        appleMapView.translatesAutoresizingMaskIntoConstraints = false
        appleMapView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        appleMapView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        appleMapView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
        appleMapView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    // MARK: - Discovering
    func updating() {
        
    }
    
    func initialLocationUpdated(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        self.appleMapView.setRegion(region, animated: true)
        
    }
    
    func currentLocationUpdated(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        self.appleMapView.setRegion(region, animated: true)
    }
    
    func loaded(trainerLocations: [MKAnnotation]) {
        self.appleMapView.addAnnotations(trainerLocations)
    }
    
    func remove(trainerLocations: [MKAnnotation]) {
        self.appleMapView.removeAnnotations(self.appleMapView.annotations)
    }
    
    func errorGettingTrainers() {
        
    }
}
