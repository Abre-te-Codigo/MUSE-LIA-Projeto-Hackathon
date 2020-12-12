//
//  ARPreviewViewController.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 24/10/20.
//

import UIKit
import QuickLook
import ARKit

class ARPreviewViewController: QLPreviewController {
    
    let dataContainer = UIView()
    let modalView = ARModalView()
    
    var itemDigital: ItemDigital!
    
    lazy var modalTopBottomConstraint = modalView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -modalMinHeight)
    lazy var modalBottomConstraint = modalView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    
    var largeModal = false
    let modalMinHeight: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        
        setupDataContainer()
    }
    
    func setupDataContainer() {
        view.addSubview(modalView)
        modalView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            modalTopBottomConstraint,
            modalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            modalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        modalView.isUserInteractionEnabled = true
        modalView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panModal)))
        modalView.configure(item: itemDigital)
    }
    
    @objc
    func panModal(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            break
        case .changed:
            let yTranslation = sender.translation(in: view).y
            if largeModal {
                if yTranslation < 0 { break }
                modalBottomConstraint.constant = yTranslation
            } else {
                if yTranslation > 0 || yTranslation < -modalView.frame.height + modalMinHeight { break }
                modalTopBottomConstraint.constant = -modalMinHeight + yTranslation
            }
        case .ended:
            let yTranslation = sender.translation(in: view).y
            if largeModal {
                largeModal = yTranslation < 50
            } else {
                largeModal = yTranslation < -50
            }
            if largeModal {
                modalTopBottomConstraint.isActive = false
                modalBottomConstraint.isActive = true
                modalBottomConstraint.constant = 0
            } else {
                modalTopBottomConstraint.isActive = true
                modalBottomConstraint.isActive = false
                modalTopBottomConstraint.constant = -modalMinHeight
            }
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        default:
            break
        }
    }
}

extension ARPreviewViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int { 1 }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let object = itemDigital.fileName
        guard let path = Bundle.main.path(forResource: object, ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }
        let url = URL(fileURLWithPath: path)
        let item = ARQuickLookPreviewItem(fileAt: url)
        return item
    }
}

extension ARPreviewViewController: QLPreviewControllerDelegate {
    func previewControllerWillDismiss(_ controller: QLPreviewController) {
        print("dismiss")
    }
}
