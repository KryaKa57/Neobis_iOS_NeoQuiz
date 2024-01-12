//
//  ArticleView.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit
import SnapKit

class ArticleView: UIView {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Nunito-Bold", size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Nunito-Medium", size: 12)
        return label
    }()
    
    lazy var descrtiptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Nunito-Medium", size: 12)
        label.numberOfLines = 0
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
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(infoLabel)
        contentStackView.addArrangedSubview(descrtiptionLabel)
        scrollView.addSubview(contentStackView)
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentStackView.snp.makeConstraints { make in
            make.edges.width.equalTo(scrollView)
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
        }
        infoLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
        }
        descrtiptionLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
        }
    }
    
    func configure(_ article: ArticleFullResponse) {
        nameLabel.text = article.name
        infoLabel.text = "#\(article.genre.prefix(1).uppercased() + article.genre.lowercased().dropFirst()) ◾️ \(article.time) minutes"
        descrtiptionLabel.text = article.description
    }
}

