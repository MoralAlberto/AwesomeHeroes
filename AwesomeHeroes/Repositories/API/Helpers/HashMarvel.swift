//
//  HashMarvel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation

struct HashMarvel {
    static func hash(timestamp: String, privateKey: String, publicKey: String) -> String {
        let semiHash = timestamp + privateKey + publicKey
        return semiHash.md5
    }
}