//
//  Networking.swift
//  Media Finder
//
//  Created by Ahmed Kamal on 3/28/20.
//  Copyright © 2020 Intake 4. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {
    
    class func loadMyMovies(search: String, completion: @escaping (_ error: Error?, _ movies: [MyMovie]?) -> Void) {
        AF.request(Urls.base, method: HTTPMethod.get, parameters: [parameterKeys.term : search, parameterKeys.media: Scope.scope] , encoding: URLEncoding.default, headers: nil).response { response in
        guard response.error == nil else {
            print(response.error!)
            completion(response.error, nil)
            return
        }
        
        guard let data = response.data else {
            print("didn't get any data from API")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let moviesArr = try decoder.decode(Count.self, from: data).results
            completion(nil, moviesArr)
            
        } catch let error {
            print(error)
        }
    }
    }
}
