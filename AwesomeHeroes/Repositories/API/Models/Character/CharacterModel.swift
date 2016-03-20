//
//  CharacterModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class CharacterModel: Mappable {
    var id: Int?
    var name: String?
    var thumbnail: CharactersThumbnailModel?
    var comics: ComicsModel?
    var series: SeriesModel?
    var stories: StoriesModel?
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        thumbnail <- map["thumbnail"]
        comics <- map["comics"]
        series <- map["series"]
        stories <- map["stories"]
    }
}