//
//  ViewController.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/24/23.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let apiKey = Env.shared.value(for: "API_KEY")
        print(apiKey)
    }


}

