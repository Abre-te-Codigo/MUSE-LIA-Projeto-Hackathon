//
//  ViewController.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 24/10/20.
//

import UIKit

class CategoryHeader: UICollectionReusableView {

    let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        textLabel.textColor = UIColor(named: "darkText") ?? .gray
        
        textLabel.text = "Categoria"
        addSubview(textLabel)
    }

    func configure(text: String, hidden: Bool) {
        textLabel.isHidden = hidden
        textLabel.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = bounds
    }
}

private let categoryHeader = "headerCategory"

class HomeViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!

    var exposicoes: [Exposicao] = []
    var instituicoes: [Instituicao] = []
    var categorias : [Categoria] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    fileprivate func setupCollection() {
        collectionView.register(UINib(nibName: "\(ExposicaoViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ExposicaoViewCell.self)")
        collectionView.register(UINib(nibName: "\(InstituicaoViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(InstituicaoViewCell.self)")
        collectionView.register(UINib(nibName: "\(CategoriaViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoriaViewCell.self)")

        collectionView.register(CategoryHeader.self, forSupplementaryViewOfKind: categoryHeader, withReuseIdentifier: "\(CategoryHeader.self)")

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    fileprivate func setupTextField() {

        let imageView = UIImageView(frame: .init(origin: .init(x: 10, y: 7.5), size: .init(width: 25, height: 25)))

        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "tintColor")
        imageView.image = UIImage(systemName: "magnifyingglass")

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        paddingView.addSubview(imageView)
        searchTextField.leftViewMode = .always
        searchTextField.leftView = paddingView
        searchTextField.tintColor = UIColor(named: "tintColor")
        searchTextField.layer.cornerRadius = .cornerRadius
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()

        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(named: "tintColor")

        exposicoes = Acervo.shared.exposicoes
        instituicoes = Acervo.shared.instituicoes
        categorias = Acervo.shared.categorias

        setupCollectionLayout()
        setupCollection()

        title = "Início"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    fileprivate func setupCollectionLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in

            let section : NSCollectionLayoutSection

            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 20
                item.contentInsets.bottom = 20

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalWidth(0.3)), subitems: [item])
                group.contentInsets.leading = 0
                group.contentInsets.top = 0
                group.contentInsets.trailing = 0

                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous

                section.contentInsets.leading = 24
                section.contentInsets.trailing = 4

            } else if sectionNumber == 1 {

                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3)))
                item.contentInsets.trailing = 24
                item.contentInsets.bottom = 20

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300)), subitems: [item])

                group.contentInsets.top = 20
                group.contentInsets.leading = 0
                group.contentInsets.trailing = 0

                section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 24
                section.contentInsets.trailing = 0
            } else {

                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)))
                item.contentInsets.bottom = 0
                item.contentInsets.trailing = 0

                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [item])

                group.contentInsets.top = 0
                group.contentInsets.leading = 0
                group.contentInsets.trailing = 0

                group.interItemSpacing = .none

                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.contentInsets = .zero

                section.contentInsets.leading = 24
                section.contentInsets.trailing = 24
            }

            if sectionNumber > 0 {
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: categoryHeader, alignment: .topLeading)

                header.contentInsets.bottom = 20

                section.boundarySupplementaryItems = [
                    header
                ]
            }

            return section
        }

        collectionView.setCollectionViewLayout(layout, animated: false)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? exposicoes.count : section == 1 ? instituicoes.count : categorias.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let instituicao = instituicoes[indexPath.row]
            let vc = InstituicaoViewController(instituicao: instituicao)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ExposicaoViewCell.self)", for: indexPath) as! ExposicaoViewCell
            cell.configure(exposicao: exposicoes[indexPath.row])
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(InstituicaoViewCell.self)", for: indexPath) as! InstituicaoViewCell
            cell.configure(instituicao: instituicoes[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoriaViewCell.self)", for: indexPath) as! CategoriaViewCell
            cell.configure(categoria: categorias[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CategoryHeader.self)", for: indexPath)

        let texto = indexPath.section == 1 ? "Acervos e Instituições" : "Categorias"

        if let header = header as? CategoryHeader {
            header.configure(text: texto, hidden: indexPath.section == 0)
        }
        return header
    }
}
