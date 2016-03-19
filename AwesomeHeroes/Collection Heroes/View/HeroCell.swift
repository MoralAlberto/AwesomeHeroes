//
//  HeroCell.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import UIKit
import Haneke

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameHero: UILabel!
    
    var viewModel = HeroCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        RACObserve(viewModel, "canReloadUI")
            .ignore(false)
            .deliverOnMainThread()
            .subscribeNext { (anyObject: AnyObject!) -> Void in
                
                self.nameHero.text = self.viewModel.name
                self.imageView.hnk_setImageFromURL(NSURL(string: self.viewModel.urlImage!), placeholder: nil, success: { image in
                    self.imageView.clipsToBounds = true
                    self.imageView.image = image
                    
                    }) { error in
                        print("Error")
                }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nameHero.text = nil
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let attributes = layoutAttributes as! HeroesLayoutAttributes
        imageViewHeightLayoutConstraint.constant = attributes.imageHeight
    }
}