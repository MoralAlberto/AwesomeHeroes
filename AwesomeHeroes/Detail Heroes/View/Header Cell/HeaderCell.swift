//
//  HeaderCell.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit
import Haneke

protocol HeaderCellDelegate: class {
    func dismissViewController()
}

class HeaderCell: UITableViewCell {
    
    var viewModel = HeaderCellViewModel()
    var delegate: HeaderCellDelegate?
    
//    @IBOutlet weak var imageHero: UIImageView!
//    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var nameHero: UILabel!
    @IBOutlet weak var imageHero: UIImageView!
    static var cellId: String {
        return "HeaderCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //delegate = self
        
        binding()
    }

    //MARK: Setup
    
    func binding() {
        RACObserve(viewModel, "canReloadUI")
            .ignore(false)
            .subscribeNext { (anyObject: AnyObject!) -> Void in
            
                self.nameHero.text = self.viewModel.name
                
                self.imageHero.hnk_setImageFromURL(NSURL(string: self.viewModel.urlImage!), placeholder: nil, success: { image in
                    self.imageHero.clipsToBounds = true
                    self.imageHero.image = image
                    
                    }) { error in
                        print("Error")
                }
        }
    }
    
    //MARK: Actions
    
    @IBAction func dismissViewController(sender: UIButton) {
        print("back button")
        delegate?.dismissViewController()
    }

}
