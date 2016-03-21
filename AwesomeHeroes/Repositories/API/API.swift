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
    
    //MARK: Heroes
    
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
    
    //MARK: Comics
    
    /** 
        Get comics from one hero
    **/
    static func comicsCharacter(withId characterId: UInt) -> SignalProducer<ComicDataWrapper, NSError> {
        return ComicsManager.comicsCharacter(withId: characterId)
    }
    
    //MARK: Stories
    
    /**
        Get stories from one hero
    **/
    static func storiesCharacter(withId characterId: UInt) -> SignalProducer<StoriesDataWrapper, NSError> {
        return StoriesManager.storiesCharacter(withId: characterId)
    }
    
}