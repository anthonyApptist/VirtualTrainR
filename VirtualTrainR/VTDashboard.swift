//
//  VTDashboard.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-07-03.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation

// Portal Protocol
protocol PortalSwitch {
    func switchToClientPortal()
    func switchToTrainerPortal()
}

protocol TrainerCalendarTab {
    func didReceiveNewRequest()
}

protocol ClientInboxTab {
    func didReceiveResponse()
}

protocol CompleteNewTrainer {
    func didCreateNewTrainer()
}

class VTDashboard: NSObject, CLLocationManagerDelegate {
    
    // account switch
    var account: Portals?
    
    // portal delegate
    var portalDelegate: PortalSwitch?
    var trainerCalendar: TrainerCalendarTab?
    var clientInbox: ClientInboxTab?
    
    // database reference
    var trainerSessionRef: DatabaseReference?
    var clientInboxRef: DatabaseReference?
    
    var locationManager: CLLocationManager?
    
    // Init
    init(initialAccount: Portals) {
        super.init()
    
        self.account = initialAccount // initial account
    }
    
    /*
    // MARK: - Switch Portals
    func switchPortals() {
        if self.account == Portals.client {
            self.portalDelegate?.switchToTrainerPortal()
        }
        if self.account == Portals.trainer {
            self.portalDelegate?.switchToClientPortal()
        }
    }
    */
    
    // MARK: - Location Manager
    func startLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopLocationManager() {
        self.locationManager?.stopUpdatingLocation()
    }

    // MARK: - Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude = manager.location?.coordinate.latitude
        let longitude = manager.location?.coordinate.longitude
        DataService.instance.setOnlineStatus(latitude: latitude!, longitude: longitude!)
    }
    
    // MARK: - Clear Observers
    func clearExistingObservers() {
        self.clientInboxRef?.removeAllObservers()
        self.trainerSessionRef?.removeAllObservers()
    }
    
    // MARK: - Create observer for Client Inbox
    func createClientInboxCalendarObserver() {
        let clientID = standardUserDefaults.value(forKey: "clientID") as! String
        self.clientInboxRef = DataService.instance.clientRef.child(clientID).child("inbox")
        
        // create observer
        self.clientInboxRef?.observe(.childAdded, with: { (snapshot) in
            self.clientInbox?.didReceiveResponse()
        }, withCancel: { (error) in
            // handle error
        })
    }
    
    // MARK: - Create observer for Trainer Calendar
    func createTrainerCalendarObserver() {
        let trainerID = standardUserDefaults.value(forKey: "trainerID") as! String
        self.trainerSessionRef = DataService.instance.trainerRef.child(trainerID).child("sessions")
        
        // create observer
        self.trainerSessionRef?.observe(.childAdded, with: { (snapshot) in
            self.trainerCalendar?.didReceiveNewRequest()
        }, withCancel: { (error) in
            // handle error
        })
    }
    
}
