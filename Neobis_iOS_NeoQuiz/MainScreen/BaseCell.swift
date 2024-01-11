//
//  BaseCell.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 11.01.2024.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func setupUI() {
        // Common setup for all cells
        backgroundColor = .white
    }
}
