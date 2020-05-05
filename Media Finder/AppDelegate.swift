//
//  AppDelegate.swift
//  Media Finder
//
//  Created by Ahmed Kamal on 2/25/20.
//  Copyright © 2020 Intake 4. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let database = DatabaseManager.shared()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        database.DbConnection()
        IQKeyboardManager.shared.enable = true
        let signUpVC = UIStoryboard.init(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signUpVC) as! SignUpVC
        let signInVC = UIStoryboard.init(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signInVC) as! SignInVC
        
        let navSignUp = UINavigationController(rootViewController: signUpVC)
        let navSignIn = UINavigationController(rootViewController: signInVC)
        
        if database.isTableExists(table: database.userData) {
            if UserDefaultsManager.shared().isLoggedIn == true {
                window?.rootViewController = MainTabBarController()
            } else {
                window?.rootViewController = navSignIn
            }
        } else {
            window?.rootViewController = navSignUp
        }
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        return true
        

       
    
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

