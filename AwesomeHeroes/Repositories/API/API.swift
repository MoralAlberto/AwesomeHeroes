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
    
    /**
        Search characters in alphabetical order
    **/
    static func characters(pageSize: UInt, offset: UInt) -> SignalProducer<CharacterDataWrapper, NSError> {
        return CharactersManager.characters(pageSize, offset: offset)
    }
    
    /**
        Search characters by name
    **/
    static func characters(withName name: String) -> SignalProducer<CharacterDataWrapper, NSError> {
        return CharactersManager.character(withName: name)
    }
}