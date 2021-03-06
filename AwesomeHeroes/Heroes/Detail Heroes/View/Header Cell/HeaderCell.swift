//
//  HeaderCell.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit
import Haneke

//MARK: Protocol
protocol HeaderCellDelegate: class {
    func dismissViewController()
    func didPressSegmentedControllerWithOption(option: Int)
}

//MARK: View
class HeaderCell: UITableViewCell {
    
    var viewModel = HeaderCellViewModel()
    var delegate: HeaderCellDelegate?
    
    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    static var cellId: String {
        return "HeaderCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        binding()
    }

    //MARK: Setup
    
    func binding() {
        RACObserve(viewModel, "canReloadUI")
            .ignore(false)
            .subscribeNext { [unowned self] (anyObject: AnyObject!) -> Void in
            
                self.nameHero.text = self.viewModel.name
                
                self.imageHero.hnk_setImageFromURL(NSURL(string: self.viewModel.urlImage!), placeholder: nil, success: { image in
                    self.imageHero.clipsToBounds = true
                    self.imageHero.image = image
                    
                    }) { error in
//                        print("Error")
                }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageHero.image = nil
        nameHero.text = nil
    }
    
    //MARK: Actions
    
    @IBAction func dismissViewController(sender: UIButton) {
        delegate?.dismissViewController()
    }
    
    @IBAction func segmentedControl(sender: UISegmentedControl) {
        delegate?.didPressSegmentedControllerWithOption(segmentedControl.selectedSegmentIndex)
    }
}
