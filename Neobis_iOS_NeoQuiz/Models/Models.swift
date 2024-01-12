//
//  Models.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation

struct QuizResponse: Codable {
    let name: String
    let genre: String
    let questionAmount: Int
}

struct ArticleResponse: Codable {
    let name: String
    let genre: String
    let time: Int
}

struct ArticleFullResponse: Codable {
    let name: String
    let genre: String
    let time: Int
    let description: String
}

struct ArticleData {
    let name: String
    let subjectName: String
    let imageName: String
    let minutes: Int
}

struct QuizData {
    let subjectName: String
    let countQuestion: Int
    let imageName: String
}
