//
//  UITableView+Customization.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/17/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import UIKit

extension UITableView {
    func tripEmptyRows() {
        self.tableFooterView = UIView.init(frame: .zero)
    }
}
