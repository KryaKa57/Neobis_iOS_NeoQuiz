//
//  ArticleCellHeader.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit
import SnapKit

class ArticleCellHeader: BaseCell {
//    var sectionIndex = 0
//    weak var delegate: NavigationDelegate?
//    
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

    override func setupUI() {
        super.setupUI()
        addSubview(searchField)
        addSubview(filterButton)
        setupConstraints()
    }

    func setupConstraints() {
        filterButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        searchField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(filterButton.snp.leading).inset(-16)
            make.height.equalTo(filterButton.snp.height)
        }
    }

//    func configure(title: String, sectionIndex: Int) {
//        titleLabel.text = title
//        self.sectionIndex = sectionIndex
//    }
//    
//    @objc func buttonTapped() {
//        delegate?.buttonTapped(sectionIndex)
//    }
}
