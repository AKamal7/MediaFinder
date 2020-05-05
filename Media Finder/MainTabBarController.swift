//
//  MainTabBarController.swift
//  Media Finder
//
//  Created by Ahmed Kamal on 4/14/20.
//  Copyright © 2020 Intake 4. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        tabBar.isTranslucent = false
    }
 
    func setUpTabBar() {
        let profile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        let profileNav = UINavigationController(rootViewController: profile)
        profile.tabBarItem.image = UIImage(named: "icons8-male-user-50")
        profile.tabBarItem.selectedImage = UIImage(named: "icons8-profile-50")
        let mediaList = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MediaListVC") as! MediaListVC
        let medialistNav = UINavigationController(rootViewController: mediaList)
        mediaList.tabBarItem.image = UIImage(named: "icons8-hbo-50")
        mediaList.tabBarItem.selectedImage = UIImage(named: "icons8-play-button-50")
        viewControllers = [medialistNav, profileNav]

    }

}
