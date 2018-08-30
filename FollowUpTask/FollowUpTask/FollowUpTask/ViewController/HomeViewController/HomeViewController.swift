//
//  HomeViewController.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/17/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import UIKit

private struct SectionCellCount {
    static let singleCellCount = 1
    static let singleSectionCount = 1
    static let itemsPerRow = 4
}

private struct Section {
    static let all: [HomeSection] = [.category, .offer, .product]
    static let category: [HomeSection] = [.category]
    static let offer: [HomeSection] = [.offer]
    static let product: [HomeSection] = [.product]
}

private struct CollectionViewRect {
    static let height:CGFloat = 70.0    //  From the interface builder
    static let singleEdgeInset = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    static let singleSpace:CGFloat = 1.0
}

private struct SectionIndex {
    static let categoryIndexPath = IndexPath
        .init(row: 0, section: Section.all.index(of: HomeSection.category) ?? 0)
    static let offerIndexPath = IndexPath
        .init(row: 0, section: Section.all.index(of: HomeSection.offer) ?? 1)
}

class HomeViewController: BaseViewController {
    
    //  MARK:-  Outlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    //  MARK:-  Properties
    fileprivate var categoryDisplay: CategoryDisplay = .minimal
    fileprivate var offerPageViewController: UIPageViewController?
    
    //  MARK:-  View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//  MARK:-  Datasource
extension HomeViewController {
    var objectMap: ObjectMap? {
        return JSONObjectMapper.getObjectMap()
    }
    
    fileprivate func toggleCategoryDisplay() {
        categoryDisplay = categoryDisplay == .minimal ? .complete : .minimal
    }
}

//  MARK:-  UI
extension HomeViewController {
    fileprivate func setupUI() {
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 350.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tripEmptyRows()
    }
    
    fileprivate func getCollectionViewHeight() -> CGFloat {
        switch categoryDisplay {
        case .minimal:
            return CollectionViewRect.height + 2.0
        case .complete:
            guard let objectMap = self.objectMap else {
                return CollectionViewRect.height
            }
            return CGFloat(objectMap.categories.count / SectionCellCount.itemsPerRow + 1 ) * CollectionViewRect.height  //  '+1' since 1st row is already painted in the collectionview
        }
    }
    
    fileprivate func reloadCategoryIndexPath() {
        tableView.beginUpdates()
        tableView.reloadRows(at: [SectionIndex.categoryIndexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    fileprivate func refreshCategorySection() {
        toggleCategoryDisplay()
        reloadCategoryIndexPath()
    }
}

//  MARK:- UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.all.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = Section.all[indexPath.section]
        switch section {
        case .category:
            let productCategoryCell = getCellForClassName(String
                .init(describing: ProductCategoryCell.self),
                                       tableView: tableView) as! ProductCategoryCell
            productCategoryCell.updateCollectionViewHeight(getCollectionViewHeight())
            return productCategoryCell
            
        case .offer:
            let offerCell = getCellForClassName(String.init(describing: OfferCell.self),
                                                tableView: tableView) as! OfferCell
            customizeOfferCell(offerCell)
            
            return offerCell
        case .product:
            let productCell = getCellForClassName(String
                .init(describing: ProductCell.self),
                                                  tableView: tableView) as! ProductCell
            setProduct(productCell, indexPath: indexPath)
            
            return productCell
        }
    }
    
    //  MARK:-  Custom functions
    fileprivate func getNumberOfRows(_ section: Int) -> Int {
        switch Section.all[section] {
        case .category, .offer:
            return SectionCellCount.singleCellCount
        case .product:
            return objectMap?.products.count ?? 0
        }
    }
    
    fileprivate func getCellForClassName(_ className: String,
                                         tableView: UITableView) -> UITableViewCell {   //  Use local reference of 'tableview' | NOT THE INSTANCE REFRENCE
        return tableView.dequeueReusableCell(withIdentifier: className)!
    }
    
    fileprivate func customizeOfferCell(_ cell: OfferCell) {
        if let objectMap = objectMap {
            
            let imagePaths = objectMap.offers.map { $0.imagePath }
            
            if offerPageViewController == nil {
                offerPageViewController = OfferPageViewController
                    .newInstance(imagePaths: imagePaths)
            }
            
            offerPageViewController!.view.frame = cell.contentView.bounds
            cell.containerView.addSubview(offerPageViewController!.view)
        }
    }
    
    fileprivate func setProduct(_ productCell: ProductCell,
                                             indexPath: IndexPath) {
        guard let product = objectMap?.products[indexPath.row] else { return }
        
        productCell.setProduct(product)
    }
}

//  MARK:-  UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let productCategoryCell = cell as? ProductCategoryCell else { return }
        
        productCategoryCell.setCollectionViewDataSourceDelegate(self)
    }
}

//  MARK:-  UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionCellCount.singleSectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectMap?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String
                .init(describing: ProductCategoryItem.self), for: indexPath) as! ProductCategoryItem
        
        if let category = self.objectMap?.categories[indexPath.row] {
            collectionViewCell.setCategoryUI(category)
            
            if .reveal == category.behaviour()  {
                collectionViewCell.toggleRevealImage(categoryDisplay)
            }
        }
        
        return collectionViewCell
    }
}

//  MARK:-  UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let actionType = objectMap!.categories[indexPath.row].behaviour() else { return }
        
        actionType == .reveal ? refreshCategorySection() : nil
        
        let collectionViewCell = collectionView.cellForItem(at: indexPath)
        
        if  let productViewCell = collectionViewCell as? ProductCategoryItem, actionType == .reveal {
            productViewCell.toggleRevealImage(categoryDisplay)
        }
    }
}

//  MARK:-  UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height:CGFloat = CollectionViewRect.height
        let width = view.frame.width / CGFloat(SectionCellCount.itemsPerRow) - 1.5  //  '1.5' calibration
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionViewRect.singleSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionViewRect.singleSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return CollectionViewRect.singleEdgeInset
    }
}
