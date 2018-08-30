//
//  ActionType.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/17/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import Foundation

/// This protocol declares functionality for UI
protocol CategoryAttributes {
    func behaviour() -> ActionMap?
}

 /*
 1. Added this protocol - to identify what kind of object it is from JSON. Basically two types
                |detail| AND |reveal|
 detail - will take you to selected detail screen
 reveal - used to expand / collapse more / less product categories
 
 2. Added this protocol since my model object shouldn't know anythiing about UI
 */
