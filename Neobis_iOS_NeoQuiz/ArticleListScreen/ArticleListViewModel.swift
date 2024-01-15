//
//  ArticleListViewModel.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation


protocol FindDelegate: AnyObject {
    func onSucceedFindRequest()
    func onFailedFindRequest()
}

class ArticleListViewModel {
    weak var getRequestDelegate: APIRequestDelegate?
    weak var findRequestDelegate: FindDelegate?
    
    var sections: [ArticleResponse] = []
    
    var colorsHex = [0xFFE0A3, 0xCCFFF6, 0xFFCCFD, 0xADD3FF, 0xFFA9A3, 0xCCFFD4, 0xD0CCFF, 0xFDFFAD]
    var filteredGenres: [String] = []
    var genres: [String] = []
    
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
    
    public func findArticles(_ text: String) {
        let endpoint = Endpoint.findArticles(name: text, genres: filteredGenres)
        NetworkManager.postData(data: nil, with: endpoint) { [weak self] (result: Result<[ArticleResponse], NetworkError>) in
            switch result {
            case .success(let res):
                self?.sections = res
                self?.findRequestDelegate?.onSucceedFindRequest()
            case .failure(_):
                self?.findRequestDelegate?.onFailedFindRequest()
            }
        }
    }
    
    
    public func getGenres() {
        let endpoint = Endpoint.getGenres()
        NetworkManager.postData(data: nil, with: endpoint) { [weak self] (result: Result<[String], NetworkError>) in
            switch result {
            case .success(let res):
                self?.genres = res
                self?.filteredGenres = res
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
