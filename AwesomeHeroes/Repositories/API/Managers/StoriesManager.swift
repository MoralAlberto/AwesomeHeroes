//
//  StoriesManager.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ReactiveCocoa

class StoriesManager: NSObject {
    
    static func storiesCharacter(withId characterId: UInt) -> SignalProducer<StoriesDataWrapper, NSError> {
        return SignalProducer<StoriesDataWrapper, NSError> { (observer, _) in
            let publicKey = Marvel.publicKey.rawValue
            let privateKey = Marvel.privateKey.rawValue
            
            let timestamp = "\(NSDate().timeIntervalSince1970 * 1000)"
            let hash = HashMarvel.hash(timestamp, privateKey: privateKey, publicKey: publicKey)
            
            let urlString = String(format: APIConstants.APIEndPoint()+APIConstants.APIPathCharacterStories(), characterId.description,"\(timestamp)", publicKey, hash)
            
            let url = NSURL(string: "\(urlString)")
            let request = NSMutableURLRequest(URL: url!)
            
            NetworkManager.dataWithRequest(request)
                .startWithNext({ data in
                    let stories: StoriesDataWrapper = ParserManager.parse(data!, toClass: StoriesDataWrapper.self)!
                    observer.sendNext(stories)
                })
        }
    }
}
