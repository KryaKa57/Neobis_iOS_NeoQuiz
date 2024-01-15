//
//  QuizListViewController.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 15.01.2024.
//

import Foundation
import UIKit

class QuizListViewController: UIViewController {
    
    let quizListView: QuizListView
    let quizListViewModel: QuizListViewModel
    let navigationManager = NavigationManager()
    var currentPage: Int = 0
    
    override func loadView() {
        view = quizListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        addDelegates()
        
        var carouselData = [CarouselData]()
        carouselData.append(.init(image: UIImage(systemName: "pencil.circle.fill"), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"))
        carouselData.append(.init(image: UIImage(systemName: "pencil.circle.fill"), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"))
        carouselData.append(.init(image: UIImage(systemName: "pencil.circle.fill"), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"))
        
        configureView(with: carouselData)
    }
    
    
    init(view: QuizListView, viewModel: QuizListViewModel) {
        quizListViewModel = viewModel
        quizListView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDelegates() {
        quizListView.collectionView.delegate = self
        quizListView.collectionView.dataSource = self
    }
    
    func setNavigation() {
        navigationManager.delegate = self
        navigationManager.setupNavigationBar(self, title: "Все квизы", hasLeftItem: true)
    }
    
}

extension QuizListViewController: NavigationManagerDelegate{
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension QuizListViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizListViewModel.carouselData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizListCell.cellId, for: indexPath) as? QuizListCell else { return UICollectionViewCell() }

        let image = quizListViewModel.carouselData[indexPath.row].image
        let text = quizListViewModel.carouselData[indexPath.row].text

        cell.configure(image: image, text: text)

        return cell
    }
    
    
    public func configureView(with data: [CarouselData]) {
        quizListViewModel.carouselData = data
        quizListView.collectionView.reloadData()
    }
}

struct CarouselData {
    let image: UIImage?
    let text: String
}
