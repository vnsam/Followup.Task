//
//  ProductCell.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/18/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    //  MARK:-  Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var legendImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//  MARK:-  Cell UI Update
extension ProductCell {
    func setProduct(_ product: Product) {
        productImageView.image = UIImage.init(named: product.imagePath)
        legendImageView.image = UIImage.init(named: product.legendImagePath)
        nameLabel.text = product.name
        deliveryLabel.text = product.deliveryTime
    }
}
