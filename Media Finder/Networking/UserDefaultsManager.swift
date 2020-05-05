//
//  UserDefaultsManager.swift
//  Media Finder
//
//  Created by Ahmed Kamal on 5/1/20.
//  Copyright © 2020 Intake 4. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    // MARK:- Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    static func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    private init() {
        
    }
    // MARK:- Properties
    var isLoggedIn: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isLoggedIn)
        } get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn)
        }
    }
}

