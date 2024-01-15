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
    let imageUrl: String
    let questionAmount: Int
}

struct ArticleResponse: Codable {
    let name: String
    let genre: String
    let time: Int
    let imageUrl: String
}

struct GenreResponse: Codable {
    let name: String
}

struct ArticleFullResponse: Codable {
    let name: String
    let genre: String
    let time: Int
    let description: String
}

struct Genre {
    let name: String
    let isSelected: Bool
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
