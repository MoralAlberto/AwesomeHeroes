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
    
    /**
        This function is awesome, you can reuse a lot of code. You only have to specify the input Data and the class that you want to parse with this data.
        There is inside a do{}catch{} because can fail the mapping.
     **/
    static func parse<T: Mappable>(data: NSData, toClass: T.Type) -> T? {
        let parsedObject: AnyObject?
        do {
            parsedObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let result = Mapper<T>().map(parsedObject)
            return result
        } catch {
            return nil
        }
    }
    
}