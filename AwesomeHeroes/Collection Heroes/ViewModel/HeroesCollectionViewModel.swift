//
//  HeroesCollectionViewModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation

class HeroesCollectionViewModel {
    
    
    func marvelCharacter() {
        API.characters().startWithNext { characters in
            print("Characters \(characters)")
            characters.data?.results?.count
//            self.collectionView?.reloadData()
        }
    }
}