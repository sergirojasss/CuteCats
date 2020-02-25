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
        let headers: HTTPHeaders = ["refreshToken": "23e679ddaf3c855907dbc1bf11cd17024675ae1b",
                                    "clientId": "b86ffb5748ea186",
                                    "clientSecret": "55cce96fd5da30896785b32100cd49ca3a4c122a",
                                    "accessToken": "8ce94f49b37ee33af8eae85f8c1e9aaedb4d7958",
                                    "expires_in": "3600",
                                    "token_type":"bearer"]
        
        AF.request("https://api.imgur.com/3/gallery/search/?q=cats", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
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
