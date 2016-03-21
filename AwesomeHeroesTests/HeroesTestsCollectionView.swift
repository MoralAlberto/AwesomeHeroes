//
//  AwesomeHeroesTests.swift
//  AwesomeHeroesTests
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import XCTest
@testable import AwesomeHeroes
import ReactiveCocoa

class HeroesTestsCollectionView: XCTestCase {
    
    var heroesCollectionViewController = HeroesCollectionViewController()
    var heroesCollectionViewModel = HeroesCollectionViewModel()
    
    override func setUp() {
        super.setUp()
        
        heroesCollectionViewController.viewModel = heroesCollectionViewModel
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetCharactersFromAPI() {
        let expectation = expectationWithDescription("Get Characters")
        
        XCTAssertTrue(self.heroesCollectionViewModel.offset == 0, "Should be the 0, at the beginning.")
        
        RACObserve(heroesCollectionViewModel, "canReloadUI")
            .ignore(false)
            .deliverOnMainThread()
            .subscribeNext { (anyObject: AnyObject!) -> Void in
                
                XCTAssert(self.heroesCollectionViewModel.arrayCharacters?.count >= 20, "Should be bigger or equal to 20.")
                XCTAssertTrue(self.heroesCollectionViewModel.canGetMoreHeroes == false, "Should be true.")
                XCTAssertTrue(self.heroesCollectionViewModel.offset >= self.heroesCollectionViewModel.pageSize, "Should be the offset bigger than the page size.")
                expectation.fulfill()
        }
        
        heroesCollectionViewModel.marvelCharacter()
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testIncreaseItemsInCollectionView() {
        let expectation = expectationWithDescription("Increase number of characters")
                
        RACObserve(heroesCollectionViewModel, "canReloadUI")
            .ignore(false)
            .deliverOnMainThread()
            .subscribeNext { (anyObject: AnyObject!) -> Void in
                
                XCTAssert(self.heroesCollectionViewModel.numberOfItems() >= 20, "Should be bigger or equal to 20.")
                XCTAssertTrue(self.heroesCollectionViewModel.searching == false, "Should be true.")
                expectation.fulfill()
        }
        
        heroesCollectionViewModel.marvelCharacter()
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
