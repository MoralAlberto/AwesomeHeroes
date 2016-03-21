//
//  HeaderCellViewModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//


import Foundation

class HeaderCellViewModel: NSObject {
    
    var hero: CharacterModel?
    var urlImage: String?
    var name: String?
    
    dynamic var canReloadUI: Bool = false
    
    func configureHeaderWith(hero: CharacterModel) {
        urlImage = (hero.thumbnail?.path)!+"/landscape_xlarge.jpg"
        name = hero.name
        
        canReloadUI = true
    }
}
