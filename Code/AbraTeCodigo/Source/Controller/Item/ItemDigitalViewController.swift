//
//  ItemDigitalViewController.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 25/10/20.
//

import UIKit

class ItemDigitalViewController: UIViewController {
    var item: ItemDigital!

    @IBOutlet weak var dadosView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var instituicaoLabel: UILabel!
    @IBOutlet weak var tituloCardLabel: UILabel!
    @IBOutlet weak var tituloBottomLabel: UILabel!
    @IBOutlet weak var instituicaoBottomLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dadosView.setupSwiftUI(ItemDataView(item: item, colorScheme: .dark))
        
        tituloLabel.text = item.nome
        instituicaoLabel.attributedText = item.instituicao.nome.withVerified()
        tituloCardLabel.text = item.nome
        tituloBottomLabel.text = item.nome
        instituicaoBottomLabel.attributedText = item.instituicao.nome.withVerified()
        descricaoLabel.text = item.descricao
        imageView.image = UIImage(named: item.imagem!)
    }
    
    @IBAction func onClickSeeAR(_ sender: Any) {
        let vc = ARPreviewViewController.loadFromNib()
            vc.itemDigital = item
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
