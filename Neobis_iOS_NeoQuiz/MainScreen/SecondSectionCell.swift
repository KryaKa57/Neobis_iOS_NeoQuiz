//
//  FirstSectionCell.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 11.01.2024.
//

import Foundation
import UIKit
import SnapKit

class SecondSectionCell: BaseCell {
    lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "Иcтория"
        label.font = UIFont(name: "Nunito-ExtraBold", size: 16)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var countOfQuestionsLabel: UILabel = {
        let label = UILabel()
        label.text = "10 вопросов"
        label.font = UIFont(name: "Nunito-Medium", size: 12)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subjectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "history")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func setupUI() {
        super.setupUI()
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2

        addSubview(subjectImageView)
        addSubview(countOfQuestionsLabel)
        addSubview(subjectLabel)
        setupConstraints()
    }

    func setupConstraints() {
        guard let width = subjectImageView.image?.size.width else { return }
        guard let height = subjectImageView.image?.size.height else { return }

        let aspectRatio = Int(width) / Int(height)
        
        subjectImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(subjectImageView.snp.height).multipliedBy(aspectRatio)
        }
        subjectLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(subjectImageView.snp.bottom).offset(24)
        }
        countOfQuestionsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subjectLabel.snp.bottom).offset(4)
        }
    }
    
    func configure(_ quiz: QuizResponse, _ color: Int) {
        subjectLabel.text = quiz.name
        countOfQuestionsLabel.text = "\(quiz.questionAmount) questions"
        subjectImageView.loadImage(from: quiz.imageUrl)
        
        backgroundColor = UIColor(rgb: color)
    }
}

//        QuizData(subjectName: "История", countQuestion: 10, imageName: "history"),
//        QuizData(subjectName: "Литература", countQuestion: 15, imageName: "literature"),
//        QuizData(subjectName: "Философия", countQuestion: 10, imageName: "philosophy"),
//        QuizData(subjectName: "Психология", countQuestion: 20, imageName: "psychology"),
