//
//  ProductCategoryCell.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/17/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import UIKit

class ProductCategoryCell: UITableViewCell {
    
    //  MARK:-  Outlets
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    //  MARK:-  Properties

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//  MARK:-  Customization
extension ProductCategoryCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
    }
    
    func updateCollectionViewHeight(_ height: CGFloat) {
        collectionViewHeightConstraint.constant = height
        collectionView.reloadData()
        layoutIfNeeded()
    }
}
