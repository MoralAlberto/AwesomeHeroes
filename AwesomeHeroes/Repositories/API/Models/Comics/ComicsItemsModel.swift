//
//  ComicsItemsModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 20/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class ComicsItemsModel: Mappable {
    
    var resourceURI: String?
    var name: String?
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        resourceURI <- map["resourceURI"]
        name <- map["name"]
    }
}