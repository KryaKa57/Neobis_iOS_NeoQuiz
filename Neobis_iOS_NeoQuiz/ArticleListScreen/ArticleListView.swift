//
//  ArticleListView.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit
import SnapKit

class ArticleListView: UIView {
    
    lazy var searchField: UITextField = {
        let textField = UITextField()

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Поиск статей", attributes: placeholderAttributes)

        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8.0

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        
        imageView.image = UIImage(systemName: "magnifyingglass",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit

        paddingView.addSubview(imageView)
        textField.leftView = paddingView
        textField.leftViewMode = .always

        return textField
    }()
    
    lazy var filterCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 6
        view.isHidden = true
        return view
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "filter")?.resize(targetSize: CGSize(width: 16, height: 16))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: self.bounds, collectionViewLayout: createLayout())
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
        collection.backgroundColor = .white
        collection.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.reuseIdentifier)
        return collection
    }()
    
    lazy var emptyStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noArticles")?.resize(targetSize: CGSize(width: 100, height: 100))
        return imageView
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "К сожалению, по результам поиска ничего не найдено"
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito", size: 16)
        label.textColor = UIColor(rgb: 0x5D5D5D)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        backgroundColor = .white
        emptyStackView.addArrangedSubview(emptyImageView)
        emptyStackView.addArrangedSubview(emptyLabel)
        
        headerStackView.addArrangedSubview(searchField)
        headerStackView.addArrangedSubview(filterButton)
        addSubview(headerStackView)
        addSubview(emptyStackView)
        addSubview(collectionView)
        addSubview(filterCircleView)
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(128)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        filterButton.snp.makeConstraints { make in
            make.width.height.equalTo(searchField.snp.height)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        emptyStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        filterCircleView.snp.makeConstraints { make in
            make.trailing.equalTo(filterButton.snp.trailing).inset(-3)
            make.top.equalTo(filterButton.snp.top).inset(-3)
            make.width.height.equalTo(12)
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.createFirstSectionLayout()
        }

        return layout
    }

    func createFirstSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .top
//        )
//        section.boundarySupplementaryItems = [header]

        return section
    }
}

