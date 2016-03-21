//
//  ComicsManager.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ReactiveCocoa

class ComicsManager: NSObject {
    static func comicsCharacter(withId characterId: UInt) -> SignalProducer<ComicDataWrapper, NSError> {
        return SignalProducer<ComicDataWrapper, NSError> { (observer, _) in

            let (publicKey, timestamp, hash) = APIConstants.mandatoryParameters()
            
            let urlString = String(format: APIConstants.APIEndPoint()+APIConstants.APIPathCharacterComics(), characterId.description,"\(timestamp)", publicKey, hash)
            
            let url = NSURL(string: "\(urlString)")
            let request = NSMutableURLRequest(URL: url!)
            
            NetworkManager.dataWithRequest(request)
                .startWithNext({ data in
                    let characters: ComicDataWrapper = ParserManager.parse(data!, toClass: ComicDataWrapper.self)!
                    observer.sendNext(characters)
                })
        }
    }
}
