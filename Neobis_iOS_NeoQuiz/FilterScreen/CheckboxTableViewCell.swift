//
//  CheckboxTableViewCell.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 13.01.2024.
//

import Foundation
import UIKit

protocol CheckboxTableViewCellDelegate: AnyObject {
    func checkboxCell(_ cell: CheckboxTableViewCell, didChangeValue value: Bool)
}

class CheckboxTableViewCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    lazy var checkboxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "checkmark")?.resize(targetSize: CGSizeMake(32, 32)), for: .selected)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.tintColor = .black
        return button
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .black
        return label
    }()

    weak var delegate: CheckboxTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white
        
        contentView.addSubview(checkboxButton)
        contentView.addSubview(titleLabel)

        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)

        checkboxButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(36)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkboxButton.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }

    @objc private func checkboxTapped() {
        checkboxButton.isSelected.toggle()
        delegate?.checkboxCell(self, didChangeValue: checkboxButton.isSelected)
    }
}
