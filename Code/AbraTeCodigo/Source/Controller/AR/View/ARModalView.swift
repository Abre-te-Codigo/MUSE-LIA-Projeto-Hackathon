//
//  ARModalView.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 25/10/20.
//

import UIKit
import SwiftUI

class ARModalView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dadosView: UIView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var instituicaoLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ARModalView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func configure(item: ItemDigital) {
        nomeLabel.text = item.nome
        instituicaoLabel.attributedText = item.instituicao.nome.withVerified()
        
        dadosView.setupSwiftUI(ItemDataView(item: item, colorScheme: .light))
        
//        let itemDadosView = UIHostingController(rootView: ItemDataView(item: item, colorScheme: .light))
//        dadosView.addSubview(itemDadosView.view)
//
//        itemDadosView.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            itemDadosView.view.topAnchor.constraint(equalTo: dadosView.topAnchor),
//            itemDadosView.view.leadingAnchor.constraint(equalTo: dadosView.leadingAnchor),
//            itemDadosView.view.trailingAnchor.constraint(equalTo: dadosView.trailingAnchor),
//            itemDadosView.view.bottomAnchor.constraint(equalTo: dadosView.bottomAnchor),
//        ])
    }

}
