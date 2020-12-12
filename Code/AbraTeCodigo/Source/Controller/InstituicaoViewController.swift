//
//  InstituicaoViewController.swift
//  AbraTeCodigo
//
//  Created by livetouch on 25/10/20.
//

import UIKit

private let categoryHeader = "headerCategory"

class InstituicaoViewController: UIViewController {

    var instituicao: Instituicao

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!

    var gradientLayer: CAGradientLayer!

    var exposicoes: [Exposicao] = []
    var itens : [ItemDigital] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()

        exposicoes = Acervo.shared.getExposicoesBy(instituicao: instituicao)
        itens = Acervo.shared.getItensBy(instituicao: instituicao)
        
        configure()

        setupCollection()
        setupCollectionLayout()
    }


    func configure() {
        coverImage.image = UIImage(named: instituicao.fotoCapa)
        titleLabel.attributedText = instituicao.nome.withVerified()
        logoImageView.image = UIImage(named: instituicao.logo)
        descriptionLabel.text = instituicao.resumo

        logoImageView.layer.cornerRadius = .cornerRadius

        setupGradient()
    }

    fileprivate func setupCollection() {
        collectionView.register(UINib(nibName: "\(ExposicaoViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ExposicaoViewCell.self)")
        collectionView.register(UINib(nibName: "\(ItemViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ItemViewCell.self)")

        collectionView.register(CategoryHeader.self, forSupplementaryViewOfKind: categoryHeader, withReuseIdentifier: "\(CategoryHeader.self)")

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    fileprivate func setupCollectionLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in

            let section : NSCollectionLayoutSection

            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 20
                item.contentInsets.bottom = 20

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.42), heightDimension: .fractionalWidth(0.42)), subitems: [item])
                group.contentInsets.leading = 0
                group.contentInsets.top = 0
                group.contentInsets.trailing = 0

                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous

                section.contentInsets.leading = 24
                section.contentInsets.trailing = 4

            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 20
                item.contentInsets.bottom = 20

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(0.35)), subitems: [item])
                group.contentInsets.leading = 0
                group.contentInsets.top = 0
                group.contentInsets.trailing = 0

                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous

                section.contentInsets.leading = 24
                section.contentInsets.trailing = 4
            }

            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: categoryHeader, alignment: .topLeading)

            header.contentInsets.bottom = 20

            section.boundarySupplementaryItems = [
                header
            ]

            return section
        }

        collectionView.setCollectionViewLayout(layout, animated: false)
    }

    fileprivate func setupGradient() {
        let color = UIColor(named: "background") ?? .white

        let gradient = CAGradientLayer()
        gradient.colors = [color.withAlphaComponent(0).cgColor, color.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = gradientView.frame

        gradientLayer = gradient

        gradientView.layer.insertSublayer(gradient, at: 0)
    }

    init(instituicao: Instituicao) {
        self.instituicao = instituicao
        super.init(nibName: "\(Self.self)", bundle: nil)

        self.title = instituicao.nome
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension InstituicaoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? itens.count : exposicoes.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let item = itens[indexPath.row]
            let vc = ItemDigitalViewController.loadFromNib()
            vc.item = item
            present(vc, animated: true)
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ItemViewCell.self)", for: indexPath) as! ItemViewCell
            cell.configure(item: itens[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ExposicaoViewCell.self)", for: indexPath) as! ExposicaoViewCell
            cell.configure(exposicao: exposicoes[indexPath.row])
            return cell
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CategoryHeader.self)", for: indexPath)

        let texto = indexPath.section == 0 ? "Objetos mais acessados" : "Exposições"

        if let header = header as? CategoryHeader {
            header.configure(text: texto, hidden: false)
        }
        return header
    }
}
