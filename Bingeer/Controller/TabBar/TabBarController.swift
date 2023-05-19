//
//  TabBarController.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/24/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBInspectable var initialIndex: Int = 0

    @IBOutlet weak var tabBarView: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarView.backgroundImage = UIImage()
        tabBarView.shadowImage = UIImage()

        tabBarView.layer.cornerRadius = 25
        tabBarView.clipsToBounds = true
        
        tabBarView.backgroundColor = UIColor(named: "cellBackground")
        tabBarView.tintColor = UIColor(red: 178.0/255, green: 101.0/255, blue: 194.0/255, alpha: 1.0)
        tabBarView.barTintColor = UIColor(red: 55.0/255, green: 40.0/255, blue: 101.0/255, alpha: 1.0)

        view.backgroundColor = .systemBackground
        
        selectedIndex = initialIndex
       
    }
    
}


