//
//  ComicDataContainer.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class ComicDataContainer: Mappable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [ComicModel]?
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        offset <- map["offset"]
        limit <- map["limit"]
        total <- map["total"]
        count <- map["count"]
        results <- map["results"]
    }
    
}
