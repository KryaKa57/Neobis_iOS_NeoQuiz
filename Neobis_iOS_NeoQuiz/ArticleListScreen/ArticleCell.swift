//
//  ArticleCell.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit
import SnapKit

class ArticleCell: BaseCell {
    lazy var descrtiptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Жизнь и правление Наполеона Бонапарта"
        label.font = UIFont(name: "Nunito-ExtraBold", size: 18)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "#История ◾️ 15 минут"
        label.font = UIFont(name: "Nunito-Medium", size: 12)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subjectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "napoleon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    override func setupUI() {
        super.setupUI()
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2

        leftStackView.addArrangedSubview(descrtiptionLabel)
        leftStackView.addArrangedSubview(subjectLabel)
        addSubview(leftStackView)
        addSubview(subjectImageView)
        setupConstraints()
    }

    func setupConstraints() {
        guard let width = subjectImageView.image?.size.width else { return }
        guard let height = subjectImageView.image?.size.height else { return }

        let aspectRatio: Double = (height) / (width)
        
        leftStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        subjectImageView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(subjectImageView.snp.height).multipliedBy(aspectRatio)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(_ article: ArticleResponse, _ color: Int) {
        descrtiptionLabel.text = article.name
        subjectLabel.text = "#\(article.genre.prefix(1).uppercased() + article.genre.lowercased().dropFirst()) ◾️ \(article.time) minutes"
        subjectImageView.loadImage(from: article.imageUrl)
        backgroundColor = UIColor(rgb: color)
    }
}
