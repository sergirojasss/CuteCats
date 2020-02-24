//
//  ViewController.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cats: [Cat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CatController.getCats { (cats) in
            self.cats = cats
        }
    }
}

