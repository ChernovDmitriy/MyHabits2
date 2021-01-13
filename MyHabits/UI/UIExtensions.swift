//
//  UIExtensions.swift
//  MyHabits
//
//  Created by Dmitriy Chernov on 12.12.2020.
//

import UIKit
extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    static var reuseID: String {
        return String(describing: Self.self)
    }
}
