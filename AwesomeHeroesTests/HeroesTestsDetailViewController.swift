//
//  HeroesDetailViewController.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import XCTest
@testable import AwesomeHeroes
import ReactiveCocoa
import Nimble
import Quick


class HeroesTestDetailViewController: QuickSpec {

    override func spec() {

        let heroDetailViewModel = HeroDetailViewModel()
        
        //1011334
        describe("Load info") {
            describe("stories from hero") {
                beforeEach {
                    heroDetailViewModel.stories(withId: 1011334)
                }
                
                context("with id: 1011334") {
                    it("Should have more than 0 stories") {
                        expect { heroDetailViewModel.stories?.count }.toEventually(beGreaterThan(0), timeout: 10)
                    }
                }
                
            }
            
            describe("comics from hero") {
                beforeEach {
                    heroDetailViewModel.characterComics(withId: 1011334)
                }
                
                context("with id: 1011334") {
                    it("Should have more than 0 comics") {
                        expect { heroDetailViewModel.comics?.count }.toEventually(beGreaterThan(0), timeout: 10)
                    }
                }
                
            }
        }
    }
    
    
}
