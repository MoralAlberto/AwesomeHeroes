//
//  API.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ReactiveCocoa

class API {
    
    //  Forward method to upper layers
    static func characters() -> SignalProducer<CharactersModel, NSError> {
        return CharactersManager.characters()
    }
    
}