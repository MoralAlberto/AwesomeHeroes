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
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}