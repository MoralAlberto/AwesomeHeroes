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
    
}