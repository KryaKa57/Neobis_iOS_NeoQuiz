//
//  SectionHeader.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 11.01.2024.
//

import Foundation
import UIKit
import SnapKit

class SectionHeader: BaseCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "Nunito-SemiBold", size: 32)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold))
        imageView.tintColor = .black
        return imageView
    }()

    override func setupUI() {
        super.setupUI()
        addSubview(titleLabel)
        addSubview(iconImageView)
        setupConstraints()
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }

    func configure(title: String) {
        titleLabel.text = title
    }
}
