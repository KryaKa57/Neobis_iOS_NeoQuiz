//
//  QuizListView.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit
import SnapKit

class QuizListView: UIView {
    lazy var collectionView: UICollectionView = {
        
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 300, height: 400)
        let cellPadding = (frame.width - 300) / 2
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        collection.register(QuizListCell.self, forCellWithReuseIdentifier: QuizListCell.cellId)
        return collection
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
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.centerX.centerY.height.width.equalToSuperview()
        }
    }
    
}

extension QuizListView {
}
