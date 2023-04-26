//
//  TabBarController.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/24/23.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet weak var tabBarView: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarView.layer.cornerRadius = 50
        tabBarView.backgroundColor = .black
        tabBarView.tintColor = .yellow
        
        
       
    }
    

   

}
