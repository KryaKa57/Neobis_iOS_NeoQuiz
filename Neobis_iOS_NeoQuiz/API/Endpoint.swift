//
//  Endpoint.swift
//  Neobis_iOS_Marketplace
//
//  Created by Alisher on 02.01.2024.
//

import Foundation

enum Endpoint {
    
    case getQuizzes(url: String = "/api/quiz")
    case getArticles(url: String = "/api/articles/all", pageNumber: Int = 1)
    case findArticles(url: String = "/api/articles/find", name: String = "", genres: [String] = [])
    case getFullArticle(url: String = "/api/articles/description", name: String = "")
    case getGenres(url: String = "/api/articles/genres")
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.addValues(for: self)
        return request
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "neo-quiz.up.railway.app"
        components.port = nil
        components.path = self.path
        components.queryItems = self.queryItems
        
        return components.url
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getArticles(_, let pageNumber):
            return [URLQueryItem(name: "pageNumber", value: "\(pageNumber)"),
                        URLQueryItem(name: "pageSize", value: "8")]
        case .getFullArticle(_, let name):
            return [URLQueryItem(name: "name", value: name)]
        case .findArticles(_, let name, let genres):
            return [URLQueryItem(name: "name", value: name),
                    URLQueryItem(name: "genre", value: genres.joined(separator: ","))]
        default:
            return []
        }
    }
    
    private var path: String {
        switch self {
        case .getQuizzes(let url), .findArticles(let url, _, _), .getArticles(let url, _), .getFullArticle(let url, _), .getGenres(let url):
            return url
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .getArticles, .getQuizzes, .findArticles, .getFullArticle, .getGenres:
            return HTTP.Method.get.rawValue
        }
    }
}

extension URLRequest {
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .getArticles, .getQuizzes, .findArticles, .getFullArticle, .getGenres:
            let cookies =  URLSession.shared.configuration.httpCookieStorage?.cookies ?? [HTTPCookie()]
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.accept.rawValue)
            self.setValue(cookies.first?.value, forHTTPHeaderField: HTTP.Headers.Key.csrfToken.rawValue)
        }
    }
}
