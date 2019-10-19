//
//  CustomTabBarController.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 20/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var tabBarIteam = UITabBarItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray], for: .normal)

        let selectedImage1 = UIImage(named: "SearchWhite")?.withRenderingMode(.alwaysOriginal)
        let deSectedImage1 = UIImage(named: "SearchGrey")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = self.tabBar.items![0]
        tabBarIteam.image = deSectedImage1
        tabBarIteam.selectedImage = selectedImage1

        let selectedImage2 = UIImage(named: "FavoriteWhite")?.withRenderingMode(.alwaysOriginal)
        let deSectedImage2 = UIImage(named: "FavoriteGrey")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = self.tabBar.items![1]
        tabBarIteam.image = deSectedImage2
        tabBarIteam.selectedImage = selectedImage2

        self.selectedIndex = 0

    }
}
