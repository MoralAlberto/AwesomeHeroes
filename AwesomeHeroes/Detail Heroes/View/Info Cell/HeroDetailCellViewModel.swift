//
//  HeroDetailCellViewModel.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation

class HeroDetailCellViewModel: NSObject {
    var comic: ComicModel?
    var story: StoriesModel?
    
    var urlImage: String?
    var name: String?
    var comicDescription: String?
    
    dynamic var canReloadUI: Bool = false
    
    func configureComicWith(comic: ComicModel) {
        urlImage = (comic.thumbnail?.path)!+"/portrait_medium.jpg"
        name = comic.title
        comicDescription = comic.description
        
        canReloadUI = true
    }
    
    func configureStoryWith(story: StoryModel) {
        if let thumbnail = story.thumbnail {
            urlImage = thumbnail.path! + "/portrait_medium.jpg"
        } 
        
        comicDescription = (story.description?.characters.count > 0) ? story.description : "No information about this story."
        name = story.title
    
        canReloadUI = true
    }
}
