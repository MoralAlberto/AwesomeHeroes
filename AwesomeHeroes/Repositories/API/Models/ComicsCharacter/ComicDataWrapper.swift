//
//  ComicDataWrapper.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class ComicDataWrapper: Mappable {
    var code: Int?
    var status: String?
    var data: ComicDataContainer?
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        code <- map["code"]
        status <- map["status"]
        data <- map["data"]
    }
}

