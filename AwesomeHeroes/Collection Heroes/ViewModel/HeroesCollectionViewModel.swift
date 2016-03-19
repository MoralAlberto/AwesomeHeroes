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
    var pageSize: UInt = 0
    var offset: UInt = 0
    var canGetMoreHeroes: Bool = true
    
    dynamic var canReload: Bool = false
    

    func marvelCharacter() {
        pageSize = 10
        canGetMoreHeroes = false
        
        API.characters(pageSize, offset: offset)
            .throttle(3.0, onScheduler: QueueScheduler.mainQueueScheduler)
            .on { x in
                print("Al final")
            }
            .startWithNext { characters in
            print("Characters \(characters)")
        
            if ((self.arrayCharacters?.isEmpty) != nil) {
                for hero in (characters.data?.results)! {
                    self.arrayCharacters?.append(hero)
                }
            } else {
                self.arrayCharacters = characters.data?.results
            }

            self.offset = self.offset + self.pageSize
            self.canReload = true
            self.canGetMoreHeroes = true
        }
    }
    
//    func canLoadMoreHeroesAtIndexPath(indexPath: NSIndexPath) -> Bool {
//        print("IndexPath: \(indexPath.item) - Heroes Count: \(arrayCharacters?.count)")
//        return (indexPath.item == arrayCharacters!.count - 3) || (indexPath.item == arrayCharacters!.count - 1)
//    }
    
    func numberOfItems() -> Int {
        if let x = self.arrayCharacters {
            return x.count
        } else {
            return 0
        }
    }
}