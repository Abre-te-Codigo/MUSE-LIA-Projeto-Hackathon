//
//  ItemViewCell.swift
//  AbraTeCodigo
//
//  Created by livetouch on 25/10/20.
//

import UIKit

class ItemViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = .cornerRadius
    }

    func configure(item: ItemDigital) {
        if let imagem = item.imagem {
            itemImageView.image = UIImage(named: imagem)
        }
        titleLabel.text = item.nome
        descriptionLabel.text = item.descricao
    }

}
