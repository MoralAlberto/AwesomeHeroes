//
//  HeroDetailViewModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation

class HeroDetailViewModel: NSObject {
    
    var comics: [ComicModel]?
    var hero: CharacterModel?
    dynamic var canReloadUI: Bool = false
    
    func characterComics(withId characterId: UInt) {
        API.comicsCharacter(withId: characterId).startWithNext { comics in
            self.comics = comics.data?.results

            self.canReloadUI = true
        }
    }
    
    func numberOfItems() -> Int {
        return (comics?.count > 0) ? (comics?.count)! + 1 : 1
    }
}
