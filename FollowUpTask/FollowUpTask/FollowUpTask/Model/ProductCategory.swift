//
//  ProductCategory.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/17/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import Foundation

typealias Type = String

/// Used at listing of product categories
class ProductCategory: Decodable {
    var index = 0
    var name = ""
    var imagePath = ""
    fileprivate var type = ""
}

//  MARK:-  ActionType - Protocol function

extension ProductCategory: CategoryAttributes {
    func behaviour() -> ActionMap? {
        return ActionMap(rawValue: type)
    }
}
