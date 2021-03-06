//
//  AppDelegate.swift
//  englishspanish
//
//  Created by Pham Van Thai on 06/05/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:UIViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        if let pathForFile = Bundle.main.path(forResource: "dictionaries", ofType: "sqlite"){
            SqliteService.shared.loadInit(linkPath: pathForFile)
        }
        if let pathForFile1 = Bundle.main.path(forResource: "spanish", ofType: "sqlite"){
            SqliteServiceSpanish.shared1.loadInit(linkPath: pathForFile1)
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

