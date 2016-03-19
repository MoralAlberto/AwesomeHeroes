//
//  ParserManager.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class ParserManager {
    
    static func parse<T: Mappable>(data: NSData, toClass: T.Type) -> T? {
        let parsedObject: AnyObject?
        do {
            parsedObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let result = Mapper<T>().map(parsedObject)
            return result
        } catch {
            print("Error \(error)")
            return nil
        }
    }
    
}