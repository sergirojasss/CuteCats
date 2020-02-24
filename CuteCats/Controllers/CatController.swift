//
//  CatController.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation


class CatController {
    
    static func getCats(completion: @escaping (_ success: [Cat]) -> Void) {
        NetworkController.getCats { (cats) in
            completion(cats)
        }
    }
    
}
