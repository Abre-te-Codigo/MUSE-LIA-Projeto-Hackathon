//
//  CategoriaViewCell.swift
//  AbraTeCodigo
//
//  Created by livetouch on 25/10/20.
//

import UIKit

class CategoriaViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = .cornerRadius
    }

    func configure(categoria: Categoria) {
        titleLabel.text = categoria.titulo
        subtitleLabel.text = categoria.subtitulo
        coverImageView.image = UIImage(named: categoria.imagem)

    }
}
