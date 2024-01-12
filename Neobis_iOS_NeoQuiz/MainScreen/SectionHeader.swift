//
//  SectionHeader.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 11.01.2024.
//

import Foundation
import UIKit
import SnapKit

protocol NavigationDelegate: AnyObject {
    func buttonTapped(_ sectionIndex: Int)
}

class SectionHeader: BaseCell {
    var sectionIndex = 0
    weak var delegate: NavigationDelegate?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "Nunito-SemiBold", size: 32)
        return label
    }()
    
    lazy var iconButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrow.right",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func setupUI() {
        super.setupUI()
        addSubview(titleLabel)
        addSubview(iconButton)
        setupConstraints()
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        iconButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }

    func configure(title: String, sectionIndex: Int) {
        titleLabel.text = title
        self.sectionIndex = sectionIndex
    }
    
    @objc func buttonTapped() {
        delegate?.buttonTapped(sectionIndex)
    }
}
