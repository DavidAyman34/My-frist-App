//
//  Networking.swift
//  MoviesApp
//
//  Created by Divo Ayman on 3/19/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit
import Alamofire
class  APIManager: NSObject {
    class func loadMedia (mediaType: String, criteria: String, completion: @escaping (_ Error: Error?, _ media: [MediaRsponse]?)-> Void) {
        let param = [Parameters.media : mediaType,
                     Parameters.term : criteria]
        Alamofire.request(Urls.media, method: HTTPMethod.get, parameters: param , encoding: URLEncoding.default, headers: nil).responseJSON { response in
            guard response.error == nil  else {
                completion(response.error, nil)
                return
            }
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            do {
                let decoder = JSONDecoder()
                let mediaArr = try decoder.decode(MediaData.self, from: data).results
                completion(nil, mediaArr)
                print("media ok")
            } catch let error {
                print("error")
                print(error)
            }
        }
    }
}


