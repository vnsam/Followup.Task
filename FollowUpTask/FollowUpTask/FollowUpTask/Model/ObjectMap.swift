//
//  ObjectMap.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/17/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import Foundation

class ObjectMap: Decodable {
    fileprivate(set) var categories: [ProductCategory] = []
    fileprivate(set) var offers: [Offer] = []
    fileprivate(set) var products: [Product] = []
}
