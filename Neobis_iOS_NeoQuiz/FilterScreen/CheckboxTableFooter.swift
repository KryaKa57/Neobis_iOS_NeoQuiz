//
//  CheckboxTableFooter.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit

class CheckboxTableFooter: UIView {

    lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont(name: "Nunito-Bold", size: 16) as Any
        ]
        button.setAttributedTitle(NSAttributedString(string: "Clear Selection", attributes: attributes), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        
        return button
    }()

    lazy var confirmButton: UIButton = {
        let button = CustomButton(textValue: "Применить")
        button.isEnabled = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(clearButton)
        addSubview(confirmButton)
        clearButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
        }
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(clearButton.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
