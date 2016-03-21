//
//  CharactersManager.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ReactiveCocoa


class CharactersManager {
        
    static func characters(pageSize: UInt, offset: UInt) -> SignalProducer<CharacterDataWrapper, NSError> {
        return SignalProducer<CharacterDataWrapper, NSError> { (observer, _) in
            
            let (publicKey, timestamp, hash) = APIConstants.mandatoryParameters()
            
            let urlString = String(format: APIConstants.APIEndPoint()+APIConstants.APIPathCharacters(), "\(timestamp)", publicKey, hash, pageSize.description, offset.description)

            let url = NSURL(string: "\(urlString)")
            let request = NSMutableURLRequest(URL: url!)
            
            NetworkManager.dataWithRequest(request)
                .startWithNext({ data in
                    if data != nil {
                        let characters: CharacterDataWrapper = ParserManager.parse(data!, toClass: CharacterDataWrapper.self)!
                        observer.sendNext(characters)
                    } else {
                        let error = NSError(domain: "errorServer", code: 1, userInfo: nil)
                        observer.sendFailed(error)
                    }
            })
        }
    }
    

    
    static func character(withName name: String) -> SignalProducer<CharacterDataWrapper, NSError> {
        return SignalProducer<CharacterDataWrapper, NSError> { (observer, _) in
            
            let (publicKey, timestamp, hash) = APIConstants.mandatoryParameters()
            
            let urlString = String(format: APIConstants.APIEndPoint()+APIConstants.APIPathCharacterWithName(), "\(timestamp)", publicKey, hash, name).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            let url = NSURL(string: urlString!)
            let request = NSMutableURLRequest(URL: url!)
            
            NetworkManager.dataWithRequest(request)
                .startWithNext({ data in
                    if data != nil {
                        let characters: CharacterDataWrapper = ParserManager.parse(data!, toClass: CharacterDataWrapper.self)!
                        observer.sendNext(characters)
                    } else {
                        let error = NSError(domain: "errorServer", code: 1, userInfo: nil)
                        observer.sendFailed(error)
                    }
                })
        }
    }
}


