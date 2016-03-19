//
//  ViewController.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit
import ReactiveCocoa
import AVFoundation

class HeroesCollectionViewController: UICollectionViewController {

    var viewModel = HeroesCollectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Settings
        let layout = self.collectionViewLayout as! HeroesLayout
        layout.delegate = self
        layout.numberOfColumns = 2
        layout.cellPadding = 4
        
        binding()
        viewModel.marvelCharacter()
    }
}

extension HeroesCollectionViewController {
    func binding() {
        RACObserve(viewModel, "canReload")
            .ignore(false)
            .deliverOnMainThread()
            .subscribeNext { (anyObject: AnyObject!) -> Void in
                
                

                self.collectionView?.reloadData()
                let layout = self.collectionViewLayout as! HeroesLayout
                layout.cache = [HeroesLayoutAttributes]()
                layout.prepareLayout()

        }
    }
}

extension HeroesCollectionViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HeroCell", forIndexPath: indexPath) as! HeroCell
        cell.viewModel.configureCellWith(viewModel.arrayCharacters![indexPath.row])
        
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if bottomEdge >= scrollView.contentSize.height && viewModel.canGetMoreHeroes {
            viewModel.marvelCharacter()
        }
    }
}

extension HeroesCollectionViewController: HeroesLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heighForImageAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        let random = arc4random_uniform(4) + 1
        return CGFloat(random * 100)
    }
    
    func collectionView(collectionView: UICollectionView, heighForNameAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        return 40
    }
}

