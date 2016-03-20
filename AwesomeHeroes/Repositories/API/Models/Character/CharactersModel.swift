//
//  CharactersModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class CharactersModel: Mappable {
    var code: Int?
    var status: String?
    var data: CharactersModelInfo?
    
    required init?(_ map: Map){}
    
    func mapping(map: Map) {
        code <- map["code"]
        status <- map["status"]
        data <- map["data"]
    }
}