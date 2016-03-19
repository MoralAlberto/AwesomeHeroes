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
    static func characters(pageSize: UInt, offset: UInt) -> SignalProducer<CharactersModel, NSError> {
        return SignalProducer<CharactersModel, NSError> { (observer, _) in
            
            let publicKey = Marvel.publicKey.rawValue
            let privateKey = Marvel.privateKey.rawValue
            
            let timestamp = "\(NSDate().timeIntervalSince1970 * 1000)"
            let hash = HashMarvel.hash(timestamp, privateKey: privateKey, publicKey: publicKey)

            let urlString = String(format: APIConstants.APIEndPoint()+APIConstants.APIPathCharacters(), "\(timestamp)", publicKey, hash, pageSize.description, offset.description)

            let url = NSURL(string: "\(urlString)")
            let request = NSMutableURLRequest(URL: url!)
            
            NetworkManager.dataWithRequest(request)
                .startWithNext({ data in
                    let characters: CharactersModel = ParserManager.parse(data, toClass: CharactersModel.self)!
                    observer.sendNext(characters)
            })
        }
    }
    
//    static func character(characterId: String) -> SignalProducer<CharactersModel, NSError> {
//        
//    }
    
}


