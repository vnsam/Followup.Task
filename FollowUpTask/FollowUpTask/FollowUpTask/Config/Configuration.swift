//
//  Config.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/17/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import Foundation

struct Configuration {
    static func getConfigJsonPath() -> URL? {
        if let path = Bundle.main.path(forResource: "config", ofType: "json") {
            return URL.init(string: "file:///" + path)
        }
        return nil
    }
}
