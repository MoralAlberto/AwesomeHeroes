//
//  HeroesCollectionViewModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ReactiveCocoa

class HeroesCollectionViewModel: NSObject {
    
    var arrayCharacters: [CharacterModel]?
    var searchCharacters: [CharacterModel]?
    
    var searching: Bool = false
    
    var pageSize: UInt = 20
    var offset: UInt = 0
    var canGetMoreHeroes: Bool = true
    
    dynamic var canReloadUI: Bool = false
    

    func marvelCharacter() {
        pageSize = 20
        canGetMoreHeroes = false
        
        API.characters(pageSize, offset: offset)
            .throttle(3.0, onScheduler: QueueScheduler.mainQueueScheduler)
            .on { x in
                print("")
            }
            .startWithNext { characters in
        
            if ((self.arrayCharacters?.isEmpty) != nil) {
                for hero in (characters.data?.results)! {
                    self.arrayCharacters?.append(hero)
                }
            } else {
                self.arrayCharacters = characters.data?.results
            }

            self.offset = self.offset + self.pageSize
            self.canReloadUI = true
            self.canGetMoreHeroes = true
        }
    }
    
    func marvelCharacter(withName name: String) {
        searching = true
        
        API.characters(withName: name)
            .on { x in
                print("\(name)")
            }
            .startWithNext { characters in
                self.searchCharacters = characters.data?.results
                self.canReloadUI = true
            }
    }
    
    func numberOfItems() -> Int {
        if searching {
            return (self.searchCharacters?.count > 0) ? (self.searchCharacters?.count)! : 0
        } else {
            return (self.arrayCharacters?.count > 0) ? (self.arrayCharacters?.count)! : 0

        }
    }
}