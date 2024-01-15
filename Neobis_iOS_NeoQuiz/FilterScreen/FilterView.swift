//
//  FilterView.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit
import SnapKit

class FilterView: UIView {
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
        label.text = "Фильтр"
        label.font = UIFont(name: "Nunito-Bold", size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(CheckboxTableViewCell.self, forCellReuseIdentifier: CheckboxTableViewCell.reuseIdentifier)
        return tableView
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
        contentStackView.addArrangedSubview(tableView)
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
        tableView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().offset(-32)
        }
    }
    
    func configureUI(_ itemCount: Int) {
        tableView.snp.updateConstraints { make in
            make.height.equalTo(100 * itemCount + 200)
        }
    }
}

