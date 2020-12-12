//
//  InstituicaoViewCell.swift
//  AbraTeCodigo
//
//  Created by livetouch on 25/10/20.
//

import UIKit

class InstituicaoViewCell: UICollectionViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        logoImageView.layer.cornerRadius = .cornerRadius
    }

    func configure(instituicao: Instituicao) {
        logoImageView.image = UIImage(named: instituicao.logo)
        titleLabel.attributedText = instituicao.nome.withVerified()
    }

}
