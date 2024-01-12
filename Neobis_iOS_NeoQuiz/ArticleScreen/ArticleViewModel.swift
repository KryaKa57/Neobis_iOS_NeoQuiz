//
//  ArticleViewModel.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation

class ArticleViewModel {
    var articleName = ""
    weak var getRequestDelegate: APIRequestDelegate?
    
    var article = ArticleFullResponse(name: "Почему вы неправильно поняли «Мастера и Маргариту»?", genre: "Литература", time: 10, description: "")

    
    public func getFullArticle() {
        let endpoint = Endpoint.getFullArticle(name: articleName)
        NetworkManager.postData(data: nil, with: endpoint) { [weak self] (result: Result<ArticleFullResponse, NetworkError>) in
            switch result {
            case .success(let res):
                self?.article = res
                self?.getRequestDelegate?.onSucceedRequest()
            case .failure(_):
                self?.getRequestDelegate?.onFailedRequest()
            }
        }
    }
    
}
