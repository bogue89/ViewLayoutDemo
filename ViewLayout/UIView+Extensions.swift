//
//  UIView+Extensions.swift
//  ViewLayout
//
//  Created by Jorge Benavides
//

import UIKit

extension UIView {
    /// gets or create the lauout constraint class for this particular view
    unowned var layout: ViewLayout { ViewLayout.instance(for: self) }
}
