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
import SVProgressHUD

class HeroesCollectionViewController: UICollectionViewController {

    var viewModel = HeroesCollectionViewModel()
    
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        SVProgressHUD.dismiss()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBarAndLeftTitleWithManualLayout()
        
        // Collection View Layout Settings
        let layout = self.collectionViewLayout as! HeroesLayout
        layout.delegate = self
        //  Number of columns in our Layout.
        layout.numberOfColumns = 2
        layout.cellPadding = 4
        
        SVProgressHUD.showWithStatus(viewModel.searchingFeedback)
        
        binding()
        viewModel.marvelCharacter()
    }
    
    //MARK: Private methods
    /**
        Create a custom titleView in our navigation controller. With a parent UIView, with subview: UILabel and UISearchBar
        It's all attached with manual layout. With NSLayoutAnchor, a fluent API for NSLayoutConstraint.
     **/
    private func addSearchBarAndLeftTitleWithManualLayout() {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.titleHeroes
        
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
    
    /**
        Reload the collection view
     **/
    private func reload(){
        self.collectionView?.reloadData()
        
        let layout = self.collectionViewLayout as! HeroesLayout
        layout.cache = [HeroesLayoutAttributes]()
        layout.prepareLayout()
    }
}

extension HeroesCollectionViewController {

    /**
        Bind the Controller with the ViewModel, then we can "listen" changes in our model and refresh our View.
     **/
    private func binding() {
        /**
            Observe canReloadUI variable within HeroesCollectionViewModel, we are observing every new update in this variable.
            Ignore when the var has false value, and the result is delivered on the main thread.
        **/
        RACObserve(viewModel, "canReloadUI")
            .ignore(false)
            .deliverOnMainThread()
            .subscribeNext { (anyObject: AnyObject!) -> Void in
                
                SVProgressHUD.dismiss()
                
                self.reload()
                self.viewModel.searching = false
        }
        
        /**
            Observe changes at searchBar text, we want to retrieve the name of a super hero (if exist at marvel's api).
            The text is throttled, it means that we only send the name when the user stops tapping.
        **/
        self.rac_signalForSelector("searchBar:textDidChange:", fromProtocol: UISearchBarDelegate.self)
            .doNext({ (AnyObject: AnyObject!) -> Void in
                SVProgressHUD.showWithStatus(self.viewModel.searchingFeedback)
            })
            .throttle(2.0)
            .subscribeNext { (AnyObject: AnyObject!) -> Void in
                
                let searchBar = AnyObject as? RACTuple
                let searchText = searchBar?.second as? String
                
                if searchText?.characters.count > 0 {
                    self.viewModel.marvelCharacter(withName: searchText!)
                } else {
                    SVProgressHUD.dismiss()
                    self.viewModel.searchCharacters = nil
                    
                    self.reload()
                }
        }
    }
}

extension HeroesCollectionViewController {
    
    /**
        Show the correct items in a section, there are two arrays arrayHeroes and searchHeroes.
     **/
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    /**
        Delegate method
     **/
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HeroCell.cellId, forIndexPath: indexPath) as! HeroCell
        
        let heroModel = viewModel.heroAtIndexPath(indexPath)
        cell.viewModel.configureCellWith(heroModel)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Open View Controller")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let heroDetailViewController = storyboard.instantiateViewControllerWithIdentifier("HeroDetailViewController") as! HeroDetailViewController
        heroDetailViewController.viewModel.hero = viewModel.heroAtIndexPath(indexPath)
        self.presentViewController(heroDetailViewController, animated: true, completion: nil)
    }
    
    /**
        Detect when the user has scrolled to the end of the UICollectionView. Then, when he arrives at the end another REST API call is sent.
     **/
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if bottomEdge >= scrollView.contentSize.height
            && viewModel.canGetMoreHeroes
            && viewModel.searchCharacters?.count <= 0 {
                SVProgressHUD.showWithStatus(viewModel.searchingFeedback)
                viewModel.marvelCharacter()
        }
    }
}

extension HeroesCollectionViewController: HeroesLayoutDelegate {
    
    /**
        Random height for hero's image.
     **/
    func collectionView(collectionView: UICollectionView, heighForImageAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        let random = arc4random_uniform(4) + 1
        return CGFloat(random * 100)
    }
    
    /**
        Height for the UILabel that shows the hero's name
     **/
    func collectionView(collectionView: UICollectionView, heighForNameAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        return 40
    }
}

extension HeroesCollectionViewController: UISearchBarDelegate {}

