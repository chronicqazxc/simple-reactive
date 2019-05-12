//
//  +UILabel.swift
//  SimpleReactive
//
//  Created by Wayne Hsiao on 2019/5/12.
//

import UIKit

extension SimpleColdSignal {
    public func bindTo(label: UILabel) {
        observe {
            label.text = $0 as? String ?? ""
        }
    }
}
