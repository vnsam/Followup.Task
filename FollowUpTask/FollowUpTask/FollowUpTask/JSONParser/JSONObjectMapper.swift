//
//  JSONParser.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/17/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import Foundation

class JSONObjectMapper {
    
    /*
                                            ---In the JSON File:---
     All objects have a property called index - 0, this is added in case if we wish to rearrange catgories based on the index they are given - if we push a JSON from server - we will automatically re-arrange product categories, offers, products.
     The code for it is not written.
     */
    
    static func getCategories() -> [ProductCategory]? {
        return JSONObjectMapper.getObjectMap()?.categories
    }
    
    static func getOffers() -> [Offer]? {
        return JSONObjectMapper.getObjectMap()?.offers
    }
    
    static func getProducts() -> [Product]? {
        return JSONObjectMapper.getObjectMap()?.products
    }
    
    static func getObjectMap() -> ObjectMap? {
        guard let configPath = Configuration.getConfigJsonPath() else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: configPath)
            
            let objectMap = try jsonDecoder.decode(ObjectMap.self, from: data)
            
            return objectMap
        }
        catch {
            print("|Error| ---\(error)\n at \(#function, #line, String.init(describing: self))")
            return nil
        }
    }
}

//  MARK:-  Internal helper functions

extension JSONObjectMapper {
    fileprivate static var jsonDecoder: JSONDecoder {
        return JSONDecoder()
    }
}
