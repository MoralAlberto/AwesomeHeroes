//
//  HeroDetailCell.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 21/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit

class HeroDetailCell: UITableViewCell {
    var viewModel = HeroDetailCellViewModel()
    
    @IBOutlet weak var nameComic: UILabel!
    @IBOutlet weak var imageComic: UIImageView!
    @IBOutlet weak var descriptionComic: UILabel!
    
    static var cellId: String {
        return "HeroDetailCell"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        binding()
    }
    
    //MARK: Setup
    
    func binding() {
        RACObserve(viewModel, "canReloadUI")
            .ignore(false)
            .subscribeNext { (anyObject: AnyObject!) -> Void in
                
                self.nameComic.text = self.viewModel.name
                self.descriptionComic.text = self.viewModel.comicDescription
                
                self.imageComic.hnk_setImageFromURL(NSURL(string: self.viewModel.urlImage!), placeholder: nil, success: { image in
                    self.imageComic.clipsToBounds = true
                    self.imageComic.image = image
                    
                    }) { error in
                        print("Error")
                }
        }
    }
    
}
