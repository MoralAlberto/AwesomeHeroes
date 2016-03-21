//
//  HeroCellViewModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation

class HeroCellViewModel: NSObject {
    
    var urlImage: String?
    var name: String?
    
    dynamic var canReloadUI: Bool = false

    func configureCellWith(hero: CharacterModel) {
        urlImage = (hero.thumbnail?.path)!+"/portrait_xlarge.jpg"
        name = hero.name
        
        canReloadUI = true
    }
}