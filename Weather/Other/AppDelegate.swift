//
//  AppDelegate.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 16.11.2021.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        guard let rootViewController = window?.rootViewController as? RootViewController else {
//            fatalError("Unexpected Root View Controller")
//        }
        
//        // Initialize Root View Model
//        let rootViewModel = RootViewModel(locationService: LocationManager())
//
//        // Configure Root View Controller
//        rootViewController.viewModel = rootViewModel
        
        NetworkMonitor.shared.startMonitoring()
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }

    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
       return true
    }

    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
       return true
    }

}

