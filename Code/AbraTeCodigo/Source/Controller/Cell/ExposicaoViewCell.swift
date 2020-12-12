//
//  ExposicaoViewCell.swift
//  AbraTeCodigo
//
//  Created by livetouch on 25/10/20.
//

import UIKit

class ExposicaoViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = .cornerRadius
        coverImageView.layer.cornerRadius = .cornerRadius
    }

    func configure(exposicao: Exposicao) {
        coverImageView.image = UIImage(named: exposicao.imagem)
        titleLabel.text = exposicao.titulo
        countLabel.text = "\(exposicao.itens.count) arquivos digitais"
    }
}
