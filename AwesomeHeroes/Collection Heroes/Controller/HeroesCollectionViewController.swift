//
//  ViewController.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Haneke
import AVFoundation

class HeroesCollectionViewController: UICollectionViewController {

    var viewModel = HeroesCollectionViewModel()
    var arrayCharacters: CharactersModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionViewLayout as! HeroesLayout
        layout.delegate = self
        layout.numberOfColumns = 2
        layout.cellPadding = 4
        
//        API.characters().startWithNext { characters in
//            print("Characters \(characters)")
//            self.arrayCharacters = characters
////            characters.data?.results?.count
//            self.collectionView?.reloadData()
//        }
        
    }
}

extension HeroesCollectionViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (self.arrayCharacters!.data?.results?.count)!
        return 20
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HeroCell", forIndexPath: indexPath) as! HeroCell
        
        cell.imageView.hnk_setImageFromURL(NSURL(string: "http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73/portrait_xlarge.jpg"), placeholder: nil, success: { image in
            print("Success")
            cell.imageView.clipsToBounds = true
            cell.imageView.image = image

//            let layout = self.collectionViewLayout as! HeroesLayout
//            layout.prepareLayout()
            
            }) { error in
            print("Error")
        }
        
        return cell
    }
}

extension HeroesCollectionViewController: HeroesLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heighForImageAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        
            let random = arc4random_uniform(4) + 1
            return CGFloat(random * 100)


    }
    
    func collectionView(collectionView: UICollectionView, heighForNameAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        return 60
    }
    
}

