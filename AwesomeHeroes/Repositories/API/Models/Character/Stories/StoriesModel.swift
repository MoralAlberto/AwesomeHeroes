//
//  StoriesModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 20/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class StoriesModel: Mappable {
    
    var items: [SeriesItemsModel]?
    var available: Int?
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        items <- map["items"]
        available <- map["available"]
    }
    
}