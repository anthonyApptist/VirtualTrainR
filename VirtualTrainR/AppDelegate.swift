//
//  AppDelegate.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-14.
//  Copyright © 2017 Apptist. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleMaps
import GooglePlaces
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Firebase app
        FirebaseApp.configure()
        
        // Stripe
        STPPaymentConfiguration.shared().publishableKey = "pk_test_MhzYed5BZgYlLLVlL99txvlg"
        STPPaymentConfiguration.shared().appleMerchantIdentifier = "merchant.com.com.VirtualTrainr"
        
        // Facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Google Maps and Places API Key
        GMSServices.provideAPIKey("AIzaSyCG9tiEX9Kh8EmX3kN-o7IpOOvHm_rBSKM")
        GMSPlacesClient.provideAPIKey("AIzaSyCG9tiEX9Kh8EmX3kN-o7IpOOvHm_rBSKM")
        
        // reset user defaults
//        self.resetUserDefaults()
        
        // sign out
//        AuthService.instance.performSignOut()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if AuthService.instance.checkSignedIn() {
            let vtDashboard = VTDashboard(initialAccount: Portals.client)
            let initialView = Dashboard(vtDashboard: vtDashboard)
//            initialView.dashboard = dashboard
            window?.rootViewController = initialView
        }
        else {
            let initialView = EntryScreen()
            window?.rootViewController = initialView
        }
        
//        let initialView = TestView()
//        window?.rootViewController = initialView
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options [UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Reset App to First Controller 
    
    
}

