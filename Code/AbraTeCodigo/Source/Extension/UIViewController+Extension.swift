//
//  UIViewController+Extension.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 24/10/20.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        Self.init(nibName: String(describing: Self.self), bundle: nil)
    }
}

extension CGFloat {
    static var cornerRadius: CGFloat = 8
}
