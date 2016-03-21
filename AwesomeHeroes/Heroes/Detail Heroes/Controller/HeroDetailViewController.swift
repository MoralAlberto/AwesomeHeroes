//
//  HeroDetailViewController.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 20/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit
import SVProgressHUD

class HeroDetailViewController: UITableViewController {

    var viewModel = HeroDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        SVProgressHUD.showWithStatus(viewModel.loadingDataFeedback)
        binding()
        viewModel.characterComics(withId: viewModel.hero!.id!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        SVProgressHUD.dismiss()
    }
    
    /**
        Bind the Controller with the View Model
     **/
    func binding() {
        RACObserve(viewModel, "canReloadUI")
        .ignore(false)
        .deliverOnMainThread()
        .subscribeNext { [unowned self] (anyObject: AnyObject!) -> Void in
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
            
            if self.viewModel.numberOfItems() == 1 {
                self.addLabelNoResults()
            }
        }
    }
    
    /**
        If there aren't any results, we add a label to display a feedback message.
     **/
    func addLabelNoResults() {
        let labelZeroResults = UILabel(frame: self.tableView.frame)
        labelZeroResults.text = self.viewModel.noResultsFeedback
        labelZeroResults.textAlignment = NSTextAlignment.Center
        self.tableView.addSubview(labelZeroResults)
        
        NSLayoutConstraint.activateConstraints([
            labelZeroResults.leadingAnchor.constraintEqualToAnchor(self.tableView.leadingAnchor),
            labelZeroResults.trailingAnchor.constraintEqualToAnchor(self.tableView.trailingAnchor),
            labelZeroResults.bottomAnchor.constraintEqualToAnchor(self.tableView.bottomAnchor),
            labelZeroResults.topAnchor.constraintEqualToAnchor(self.tableView.topAnchor),
            labelZeroResults.centerYAnchor.constraintEqualToAnchor(self.tableView.centerYAnchor)
            ])
    }
}

//MARK: TableView Delegates
extension HeroDetailViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    /**
        Display the correct info, depending on: the first cell we will show the hero basic info, and within the other cells we are gonna show the comics or stories information.
     **/
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var headerCell: HeaderCell
        var infoCell: HeroDetailCell
        
        if (indexPath.row < 1) {
            headerCell = tableView.dequeueReusableCellWithIdentifier(HeaderCell.cellId, forIndexPath: indexPath) as! HeaderCell
            headerCell.delegate = self
            headerCell.viewModel.configureHeaderWith(viewModel.hero!)
            
            return headerCell
        } else {
            infoCell = tableView.dequeueReusableCellWithIdentifier(HeroDetailCell.cellId, forIndexPath: indexPath) as! HeroDetailCell
            
            if viewModel.selectedSegment == 0 {
                infoCell.viewModel.configureComicWith(viewModel.comics![indexPath.row-1])
            } else {
                infoCell.viewModel.configureStoryWith(viewModel.stories![indexPath.row-1])
            }

            return infoCell
        }
        
    }
}

//MARK: Delegates Methods from HeaderCell
extension HeroDetailViewController: HeaderCellDelegate {
    /**
        If the user taps the left top corner button, we'll dismiss the current view controller
     **/
    func dismissViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didPressSegmentedControllerWithOption(option: Int) {
        SVProgressHUD.showWithStatus(viewModel.loadingDataFeedback)
        viewModel.createRequestWithOption(option)
    }
}