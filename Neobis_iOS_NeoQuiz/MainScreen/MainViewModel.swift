//
//  MainViewModel.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 11.01.2024.
//

import Foundation

protocol APIRequestDelegate: AnyObject {
    func onSucceedRequest()
    func onFailedRequest()
}

class MainViewModel {
    var firstSectionViewModel = FirstSectionViewModel()
    var secondSectionViewModel = SecondSectionViewModel()
    
    weak var getRequestDelegate: APIRequestDelegate?
    
    public func getQuizes() {
        let endpoint = Endpoint.getQuizzes()
        
        NetworkManager.postData(data: nil, with: endpoint) { [weak self] (result: Result<[QuizResponse], NetworkError>) in
            switch result {
            case .success(let res):
                self?.secondSectionViewModel.sections = res
                self?.getRequestDelegate?.onSucceedRequest()
            case .failure(_):
                self?.getRequestDelegate?.onFailedRequest()
            }
        }
    }
    
    public func getArticles() {
        let endpoint = Endpoint.getArticles()
        NetworkManager.postData(data: nil, with: endpoint) { [weak self] (result: Result<[ArticleResponse], NetworkError>) in
            switch result {
            case .success(let res):
                self?.firstSectionViewModel.sections = res
                self?.getRequestDelegate?.onSucceedRequest()
            case .failure(_):
                self?.getRequestDelegate?.onFailedRequest()
            }
        }
    }
    
}
