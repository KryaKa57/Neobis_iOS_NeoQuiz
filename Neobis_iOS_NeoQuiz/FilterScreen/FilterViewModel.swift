//
//  FilterViewModel.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation

class FilterViewModel {
    weak var getRequestDelegate: APIRequestDelegate?
    
    var genres: [String] = []
    var selectedItems: [Bool] = []
    
    func getArrays(_ genres: [String], _ selectedGenres: [String]) {
        self.genres = genres
        
        var boolArray = Array(repeating: false, count: genres.count)

        for (index, element) in genres.enumerated() {
            boolArray[index] = selectedGenres.contains(element)
        }
        
        if boolArray.contains(false) {
            self.selectedItems = boolArray
        } else {
            self.selectedItems = Array(repeating: false, count: genres.count)
        }
    }
}
