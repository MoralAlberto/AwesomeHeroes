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
        
        binding()
        
        SVProgressHUD.showWithStatus(viewModel.loadingDataFeedback)
        viewModel.characterComics(withId: viewModel.hero!.id!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        SVProgressHUD.dismiss()
    }
    
    func binding() {
        RACObserve(viewModel, "canReloadUI")
        .ignore(false)
        .deliverOnMainThread()
        .subscribeNext { [unowned self] (anyObject: AnyObject!) -> Void in
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
            
            if self.viewModel.numberOfItems() == 1 {
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
    }
}

extension HeroDetailViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
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

extension HeroDetailViewController: HeaderCellDelegate {
    func dismissViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didPressSegmentedControllerWithOption(option: Int) {
        SVProgressHUD.showWithStatus(viewModel.loadingDataFeedback)
        viewModel.createRequestWithOption(option)
    }
}