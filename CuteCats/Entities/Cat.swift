//
//  Cat.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation

class Cat {
    var id: String!
    var title: String?
    var link: String!
    var views: Int!
    
    init(title: String? = nil, link: String, views: Int) {
        self.id = UUID().uuidString
        self.title = title
        self.link = link
        self.views = views
    }
}
