//
//  FirstSectionViewModel.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 11.01.2024.
//

import Foundation

class FirstSectionViewModel {
    var sections: [ArticleResponse] = [
        ArticleResponse(name: "Жизнь и правление Наполеона Бонапарта", genre: "История", time: 10),
        ArticleResponse(name: "Философия Аристотеля", genre: "Философия", time: 10),
        ArticleResponse(name: "Почему Чехов не так прост?", genre: "Литература", time: 10),
        ArticleResponse(name: "Почему вы неправильно поняли «Мастера и Маргариту»?", genre: "Литература", time: 10)
//        ArticleData(name: "Жизнь и правление Наполеона Бонапарта", subjectName: "История", imageName: "napoleon", minutes: 15),
//        ArticleData(name: "Философия Аристотеля", subjectName: "Философия", imageName: "aristotel", minutes: 15),
//        ArticleData(name: "Почему Чехов не так прост?", subjectName: "Литература", imageName: "chekhov", minutes: 10),
//        ArticleData(name: "Почему вы неправильно поняли «Мастера и Маргариту»?", subjectName: "Литература", imageName: "margarita", minutes: 10)
    ]
    
    var colorsHex = [0xFFE0A3, 0xCCFFF6, 0xFFCCFD, 0xADD3FF, 0xFFA9A3, 0xCCFFD4, 0xD0CCFF, 0xFDFFAD]
    
}
