//
//  UIView+Extension.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 25/10/20.
//

import UIKit
import SwiftUI

extension UIView {
    func setupSwiftUI<Content: View>(_ view: Content) {
        let controller = UIHostingController(rootView: view)
        addSubview(controller.view)
        
        controller.view.backgroundColor = .clear
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
