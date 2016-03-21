//
//  HeroDetailViewModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation

class HeroDetailViewModel: NSObject {
    
    var hero: CharacterModel?
    var comics: [ComicModel]?
    var stories: [StoryModel]?
    var selectedSegment: Int = 0
    
    var loadingDataFeedback: String {
        return NSLocalizedString("Loading Data", comment: "Loading Data")
    }
    
    var noResultsFeedback: String {
        return NSLocalizedString("Sorry, 0 results", comment: "Sorry, 0 results")
    }
    

    dynamic var canReloadUI: Bool = false
    
    func characterComics(withId characterId: UInt) {
        API.comicsCharacter(withId: characterId).startWithNext { [unowned self] comics in
            self.comics = comics.data?.results
            self.stories = nil
            self.canReloadUI = true
        }
    }
    
    func stories(withId characterId: UInt) {
        API.storiesCharacter(withId: characterId).startWithNext { [unowned self] stories in
            self.comics = nil
            self.stories = stories.data?.results
            self.canReloadUI = true
        }
    }
    
    func createRequestWithOption(option: Int) {
        selectedSegment = option
        if option == 0 {
            self.characterComics(withId: (hero?.id)!)
        } else {
            self.stories(withId: (hero?.id)!)
        }
    }
    
    func numberOfItems() -> Int {
        if selectedSegment == 0 {
            return (comics?.count > 0) ? (comics?.count)! + 1 : 1
        } else {
            return (stories?.count > 0) ? (stories?.count)! + 1 : 1
        }
    }
}
