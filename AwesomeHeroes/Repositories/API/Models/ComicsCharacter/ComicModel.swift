//
//  ComicModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class ComicModel: Mappable {
    var id: Int?
    var title: String?
    var description: String?
    var thumbnail: CharactersThumbnailModel?

    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        thumbnail <- map["thumbnail"]

    }
}
