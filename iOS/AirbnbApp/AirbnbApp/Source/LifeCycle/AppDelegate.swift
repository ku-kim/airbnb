//
//  AppDelegate.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .Custom.gray6
        
        let appearance = UINavigationBar.appearance()
        appearance.scrollEdgeAppearance = navigationBarAppearance
        appearance.compactAppearance = navigationBarAppearance
        appearance.standardAppearance = navigationBarAppearance
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
}
