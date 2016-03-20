//
//  NetworkManager.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ReactiveCocoa

class NetworkManager {
    
    /**
        Instead of using Alamofire or AFNetworking, I create the request with the next function, using RAC4.
        If the request fails, then the signal retry 2 more times, If we have a successful response, this data is send trought the signal to upper layers, in this case to CharactersManager. 
     **/
    class func dataWithRequest(request: NSMutableURLRequest) -> SignalProducer<NSData, NSError> {
        return NSURLSession.sharedSession().rac_dataWithRequest(request)
            .retry(2)
            .map { data, URLResponse in
                return data
            }
            .flatMapError { error in
                print("Network error ocurred \(error)")
                return SignalProducer.empty
        }
    }
}