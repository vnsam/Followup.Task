//
//  ProductCategoryItem.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/17/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import UIKit

class ProductCategoryItem: UICollectionViewCell {
    //  MARK:-  Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

}

//  MARK:-  Item UI Customization
extension ProductCategoryItem {
    func setCategoryUI(_ productCategory: ProductCategory) {
        nameLabel.text = productCategory.name
        imageView.image = UIImage(named: productCategory.imagePath)
    }
    
    func toggleRevealImage(_ categoryDisplay: CategoryDisplay) {
        
        var text = ""
        var image: UIImage?
        
        if categoryDisplay == .minimal {
            image = UIImage.init(named: "more-button")
            text = NSLocalizedString("More", comment: "More")
        } else {
            image = UIImage.init(named: "less-arrow")
            text = NSLocalizedString("Less", comment: "Less")
        }
        
        nameLabel.text = text
        imageView.image = image
        
    }
}
