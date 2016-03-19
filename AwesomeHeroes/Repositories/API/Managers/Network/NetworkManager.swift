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