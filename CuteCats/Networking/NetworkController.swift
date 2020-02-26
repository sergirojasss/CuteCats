//
//  NetworkController.swift
//  CuteCats
//
//  Created by Sergi Rojas on 24/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkController {
    
    static func getCats(completion: @escaping (_ success: [Cat]) -> Void) {
        
        //        "https://api.imgur.com/3/gallery/search/?q=cats"

        AF.request("https://api.imgur.com/3/gallery/search/?client_id=b86ffb5748ea186&q=cats", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let responseData = response.data {
                    let responseJson: JSON = JSON(responseData)
                    print(responseJson)
                    var cats: [Cat] = []
                    for json in responseJson["data"].arrayValue {
                        for unit in json["images"].arrayValue {
                            if !unit["animated"].boolValue { //makeing sure it's a picture
                            let cat: Cat = Cat(title: unit["description"].stringValue, link: unit["link"].stringValue, views: unit["views"].intValue)
                            
                            cats.append(cat)
                            }
                        }
                    }
                    completion(cats)
                }
            break
            case .failure(let error):
            
            print(error)
        }
    }
    
}

}
