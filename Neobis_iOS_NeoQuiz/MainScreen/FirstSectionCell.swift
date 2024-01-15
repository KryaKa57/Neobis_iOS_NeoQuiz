//
//  FirstSectionCell.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 11.01.2024.
//

import Foundation
import UIKit
import SnapKit

class FirstSectionCell: BaseCell {
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
        label.text = "#История"
        label.font = UIFont(name: "Nunito-ExtraBold", size: 12)
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
    
    override func setupUI() {
        super.setupUI()
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2

        addSubview(descrtiptionLabel)
        addSubview(subjectLabel)
        addSubview(subjectImageView)
        setupConstraints()
    }

    func setupConstraints() {
        guard let width = subjectImageView.image?.size.width else { return }
        guard let height = subjectImageView.image?.size.height else { return }

        let aspectRatio = Int(width) / Int(height)
        
        descrtiptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        subjectLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().dividedBy(2)
        }
        subjectImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(subjectImageView.snp.width).multipliedBy(aspectRatio)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(_ article: ArticleResponse, _ color: Int) {
        descrtiptionLabel.text = article.name
        subjectLabel.text = "#\(article.genre.prefix(1).uppercased() + article.genre.lowercased().dropFirst())"
        subjectImageView.loadImage(from: article.imageUrl)
        backgroundColor = UIColor(rgb: color)
    }
}
