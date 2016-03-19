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
        
        addSearchBarAndLeftTitleWithManualLayout()
        // Layout Settings
        let layout = self.collectionViewLayout as! HeroesLayout
        layout.delegate = self
        layout.numberOfColumns = 2
        layout.cellPadding = 4
        
        binding()
        viewModel.marvelCharacter()
    }
    
    func addSearchBarAndLeftTitleWithManualLayout() {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Heros"
        
        let simpleView = UIView()
        simpleView.translatesAutoresizingMaskIntoConstraints = false
        
        simpleView.addSubview(searchBar)
        simpleView.addSubview(label)
        
        self.navigationItem.titleView = simpleView
        
        NSLayoutConstraint.activateConstraints([
            simpleView.leadingAnchor.constraintEqualToAnchor(self.navigationController?.navigationBar.leadingAnchor),
            simpleView.trailingAnchor.constraintEqualToAnchor(self.navigationController?.navigationBar.trailingAnchor),
            simpleView.bottomAnchor.constraintEqualToAnchor(self.navigationController?.navigationBar.bottomAnchor),
            simpleView.topAnchor.constraintEqualToAnchor(self.navigationController?.navigationBar.topAnchor)
            ])
        
        NSLayoutConstraint.activateConstraints([
            searchBar.leadingAnchor.constraintEqualToAnchor(simpleView.leadingAnchor, constant: 60),
            searchBar.trailingAnchor.constraintEqualToAnchor(simpleView.trailingAnchor, constant: -8),
            searchBar.bottomAnchor.constraintEqualToAnchor(simpleView.bottomAnchor)
            ])
        
        NSLayoutConstraint.activateConstraints([
            label.leadingAnchor.constraintEqualToAnchor(simpleView.leadingAnchor, constant: 4),
            label.trailingAnchor.constraintEqualToAnchor(simpleView.trailingAnchor, constant: 4),
            label.centerYAnchor.constraintEqualToAnchor(searchBar.centerYAnchor)
            ])
    }
}

extension HeroesCollectionViewController {
    func binding() {
        RACObserve(viewModel, "canReloadUI")
            .ignore(false)
            .deliverOnMainThread()
            .subscribeNext { (anyObject: AnyObject!) -> Void in
                self.collectionView?.reloadData()
                let layout = self.collectionViewLayout as! HeroesLayout
                layout.cache = [HeroesLayoutAttributes]()
                layout.prepareLayout()
        }
        
        self.rac_signalForSelector("searchBar:textDidChange:", fromProtocol: UISearchBarDelegate.self)
            .doNext({ (AnyObject: AnyObject!) -> Void in
                
            })
            .throttle(1.0)
            .subscribeNext { (AnyObject: AnyObject!) -> Void in
                
                let searchBar = AnyObject as? RACTuple
                let searchText = searchBar?.second as? String
                
                print("SEARCH: \(searchText)")
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

extension HeroesCollectionViewController: UISearchBarDelegate {
    
}
