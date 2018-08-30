//
//  FollowUpTaskTests.swift
//  FollowUpTaskTests
//
//  Created by Narayanasamy, Vignesh on 2/18/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import XCTest
@testable import FollowUpTask

class FollowUpTaskTests: XCTestCase {
    
    var objectMap: ObjectMap!
    var products: [Product]!
    var offers: [Offer]!
    var productCategories: [ProductCategory]!
    
    override func setUp() {
        super.setUp()
        
        objectMap = JSONObjectMapper.getObjectMap()
        
        products = JSONObjectMapper.getProducts()
        
        offers = JSONObjectMapper.getOffers()
        
        productCategories = JSONObjectMapper.getCategories()
    }
    
    override func tearDown() {
        
        objectMap = nil
        
        products = nil
        
        offers = nil
        
        productCategories = nil
        
        super.tearDown()
    }
    
    /// Test if the 'objectMap' is returned properly
    func testObjectValid() {
        XCTAssertNotNil(objectMap)
    }
    
    /// Test if all the 'products' are constructed from JSON
    func testProductsNotNil() {
        XCTAssertNotNil(products)
    }
    
    /// Test if all the 'offers' are constructed from JSON
    func testOffersNotNil() {
        XCTAssertNotNil(offers)
    }
    
    /// Test if all the 'productCategories' are constructed from JSON
    func testProductCategoriesNotNil() {
        XCTAssertNotNil(productCategories)
    }

    /// Test ObjectMap construction performance
    func testObjectMappingPerformance() {
        self.measure {
            _ = JSONObjectMapper.getObjectMap()
        }
    }
    
}
