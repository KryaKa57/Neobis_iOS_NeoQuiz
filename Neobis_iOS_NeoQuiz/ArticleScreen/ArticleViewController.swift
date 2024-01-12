//
//  ArticleViewController.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit

class ArticleViewController: UIViewController {
    
    let articleView: ArticleView
    let articleViewModel: ArticleViewModel
    let navigationManager = NavigationManager()
    
    override func loadView() {
        view = articleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        articleViewModel.getFullArticle()
        setNavigation()
        addDelegates()
    }
    
    init(view: ArticleView, viewModel: ArticleViewModel, articleName: String) {
        articleViewModel = viewModel
        articleView = view
        articleViewModel.articleName = articleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDelegates() {
        articleViewModel.getRequestDelegate = self
    }
    
    func setNavigation() {
        navigationManager.delegate = self
        navigationManager.setupNavigationBar(self, title: "", hasLeftItem: true)
    }
}

extension ArticleViewController: APIRequestDelegate {
    func onSucceedRequest() {
        DispatchQueue.main.async {
            self.articleView.configure(self.articleViewModel.article)
        }
    }
    
    func onFailedRequest() {
        
    }
}

extension ArticleViewController: NavigationManagerDelegate{
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

