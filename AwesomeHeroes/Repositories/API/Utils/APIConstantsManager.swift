//
//  APIConstantsManager.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation

/**
    All the REST API end points defined in APIConstants.plist.
 **/
enum APIPaths: String {
    case endPoint   = "APIEndPoint"
    case characters = "APIPaths.APIPathCharacters"
    case charactersWithName = "APIPaths.APIPathCharactersWithName"
    case charactersComics = "APIPaths.APIPathComicsCharacter"
    case charactersSeries = "APIPaths.APIPathSeriesCharacter"
    case charactersStories = "APIPaths.APIPathStoriesCharacter"
}

/**
    Load the correct .plist resource with all the REST API end points: characters, stories, creators.
**/
struct APIConstantsManager {
    
    static var APIConstants = "APIConstants"

    static func setupPlist() -> NSDictionary {
        let path = NSBundle.mainBundle().pathForResource(APIConstants, ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        return dict!
    }
}


/**
    Get a specific path to initiate a request.
 **/
struct APIConstants {
    
    static var valueDict: NSDictionary = APIConstantsManager.setupPlist() as NSDictionary
    
    static func APIEndPoint() -> String! {
        return valueDict[APIPaths.endPoint.rawValue] as! String
    }
    
    static func APIPathCharacters() -> String! {
        return valueDict.valueForKeyPath(APIPaths.characters.rawValue) as! String
    }
    
    static func APIPathCharacterWithName() -> String! {
        return valueDict.valueForKeyPath(APIPaths.charactersWithName.rawValue) as! String
    }
    
    static func APIPathCharacterComics() -> String! {
        return valueDict.valueForKeyPath(APIPaths.charactersComics.rawValue) as! String
    }
    
    static func APIPathCharacterSeries() -> String! {
        return valueDict.valueForKeyPath(APIPaths.charactersSeries.rawValue) as! String
    }
    
    static func APIPathCharacterStories() -> String! {
        return valueDict.valueForKeyPath(APIPaths.charactersStories.rawValue) as! String
    }
    
    static func mandatoryParameters() -> (String, String, String) {
        let publicKey = Marvel.publicKey.rawValue
        let privateKey = Marvel.privateKey.rawValue
        
        let timestamp = "\(NSDate().timeIntervalSince1970 * 1000)"
        let hash = HashMarvel.hash(timestamp, privateKey: privateKey, publicKey: publicKey)
        
        return (publicKey, timestamp, hash)
    }
    
}