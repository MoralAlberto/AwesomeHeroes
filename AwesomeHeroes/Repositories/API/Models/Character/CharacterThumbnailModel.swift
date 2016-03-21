//
//  CharacterThumbnailModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class CharactersThumbnailModel: Mappable {

    var path: String?
    var fileExtension: String?
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        path <- map["path"]
        fileExtension <- map["extension"]
    }

}