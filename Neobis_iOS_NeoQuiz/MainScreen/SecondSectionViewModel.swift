//
//  SecondSectionViewModel.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 11.01.2024.
//

import Foundation

class SecondSectionViewModel {
    var sections: [QuizResponse] = [
        QuizResponse(name: "История", genre: "История", questionAmount: 0),
        QuizResponse(name: "История", genre: "История", questionAmount: 0),
        QuizResponse(name: "История", genre: "История", questionAmount: 0),
        QuizResponse(name: "История", genre: "История", questionAmount: 0)
        
//        QuizData(subjectName: "История", countQuestion: 10, imageName: "history"),
//        QuizData(subjectName: "Литература", countQuestion: 15, imageName: "literature"),
//        QuizData(subjectName: "Философия", countQuestion: 10, imageName: "philosophy"),
//        QuizData(subjectName: "Психология", countQuestion: 20, imageName: "psychology"),
    ]
    
    var colorsHex = [0xFFA9A3,0xADD3FF,0xCBF89E,0xDAB5FF]
    
}
