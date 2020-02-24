//
//  Cat.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation

class Cat {
    var name: String?
    var link: String!
    var views: Int!
    
    init(name: String? = nil, link: String, views: Int) {
        self.name = name
        self.link = link
        self.views = views
    }
}
