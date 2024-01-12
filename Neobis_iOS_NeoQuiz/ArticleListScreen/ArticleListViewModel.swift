//
//  ArticleListViewModel.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation

protocol FilterDelegate: AnyObject {
    func onSucceedFilterRequest()
    func onFailedFilterRequest()
}

class ArticleListViewModel {
    weak var getRequestDelegate: APIRequestDelegate?
    weak var filterRequestDelegate: FilterDelegate?
    
    var sections: [ArticleResponse] = [
        ArticleResponse(name: "Жизнь и правление Наполеона Бонапарта", genre: "История", time: 10),
        ArticleResponse(name: "Философия Аристотеля", genre: "Философия", time: 10),
        ArticleResponse(name: "Почему Чехов не так прост?", genre: "Литература", time: 10),
        ArticleResponse(name: "Почему вы неправильно поняли «Мастера и Маргариту»?", genre: "Литература", time: 10)
    ]
    
    var colorsHex = [0xFFE0A3, 0xCCFFF6, 0xFFCCFD, 0xADD3FF, 0xFFA9A3, 0xCCFFD4, 0xD0CCFF, 0xFDFFAD]
    
    public func getArticles() {
        let endpoint = Endpoint.getArticles()
        NetworkManager.postData(data: nil, with: endpoint) { [weak self] (result: Result<[ArticleResponse], NetworkError>) in
            switch result {
            case .success(let res):
                self?.sections = res
                self?.getRequestDelegate?.onSucceedRequest()
            case .failure(_):
                self?.getRequestDelegate?.onFailedRequest()
            }
        }
    }
    
    public func filterArticles(_ text: String) {
        let endpoint = Endpoint.filterArticles(name: text)
        NetworkManager.postData(data: nil, with: endpoint) { [weak self] (result: Result<[ArticleResponse], NetworkError>) in
            switch result {
            case .success(let res):
                self?.sections = res
                self?.filterRequestDelegate?.onSucceedFilterRequest()
            case .failure(_):
                self?.filterRequestDelegate?.onFailedFilterRequest()
            }
        }
    }
}
