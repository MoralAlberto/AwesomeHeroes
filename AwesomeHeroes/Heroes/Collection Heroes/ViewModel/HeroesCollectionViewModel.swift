//
//  HeroesCollectionViewModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ReactiveCocoa

/**
    Here take place the business logic, when the mdoel is changed the view model notifies the view controller to update the info showed on the screen.
 **/
class HeroesCollectionViewModel: NSObject {
    
    var arrayCharacters: [CharacterModel]?
    var searchCharacters: [CharacterModel]?
    
    var searching: Bool = false
    
    var pageSize: UInt = 20
    var offset: UInt = 0
    var canGetMoreHeroes: Bool = true
    
    dynamic var canReloadUI: Bool = false
    dynamic var serverError: Bool = false
    
    var titleHeroes: String {
        return NSLocalizedString("Heroes", comment: "Heroes")
    }
    
    var searchingFeedback: String {
        return NSLocalizedString("Searching more heroes! 😃", comment: "Searching more heroes! 😃")
    }
    
    var serverErrorFeedBack: String {
        return NSLocalizedString("Server Error", comment: "Server Error")
    }
    
    /**
        API Call to get heroes. The heroes ara retrived from the API and correctly parsed in a model, then are inserted inside an array and displayed on the screen.
     **/
    func marvelCharacter() {
        pageSize = 20
        canGetMoreHeroes = false
        
        API.characters(pageSize, offset: offset)
            .throttle(2.0, onScheduler: QueueScheduler.mainQueueScheduler)
            .on(failed: { error in
                self.serverError = true
                self.canGetMoreHeroes = true
            })
            .startWithNext { [unowned self] characters in
                
                if let charactersAPI = characters.data?.results {
                    if ((self.arrayCharacters?.isEmpty) != nil) {
                        for hero in charactersAPI {
                            self.arrayCharacters?.append(hero)
                        }
                    } else {
                        self.arrayCharacters = charactersAPI
                    }
                    
                    self.offset = self.offset + self.pageSize
                    self.canReloadUI = true
                    self.canGetMoreHeroes = true
                }
        }
    }
    
    /**
     API Call to get heroes that has a coincidence with the text introduced in our search bar. The heroes ara retrived from the API and correctly parsed in a model, then are inserted inside an array and displayed on the screen.
     **/
    func marvelCharacter(withName name: String) {
        searching = true
        
        API.characters(withName: name)
            .on(failed: { error in
                self.serverError = true
            })
            .startWithNext { [unowned self] characters in
                self.searchCharacters = characters.data?.results
                self.canReloadUI = true
            }
    }

    /**
        There are two arrays, one for storing heroes when the user is scrolling, and another array to save the search instroduced in our search bar.
     **/
    func heroAtIndexPath(indexPath: NSIndexPath) -> CharacterModel {
        return (searchCharacters?.count > 0) ? searchCharacters![indexPath.row] : arrayCharacters![indexPath.row]
    }
    
    
    func numberOfItems() -> Int {
        if searching {
            return (searchCharacters?.count > 0) ? (searchCharacters?.count)! : 0
        } else {
            return (arrayCharacters?.count > 0) ? (arrayCharacters?.count)! : 0

        }
    }
}