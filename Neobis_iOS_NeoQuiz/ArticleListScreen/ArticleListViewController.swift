//
//  ArticleListViewController.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit

class ArticleListViewController: UIViewController {
    
    let articleListView: ArticleListView
    let articleListViewModel: ArticleListViewModel
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    let navigationManager = NavigationManager()
    
    override func loadView() {
        view = articleListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        articleListViewModel.getArticles()
        configureCollectionView()
        configureDataSource()
        setNavigation()
        addDelegates()
    }
    
    init(view: ArticleListView, viewModel: ArticleListViewModel) {
        articleListViewModel = viewModel
        articleListView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDelegates() {
        articleListViewModel.getRequestDelegate = self
        articleListViewModel.filterRequestDelegate = self
    }
    
    func setNavigation() {
        navigationManager.delegate = self
        navigationManager.setupNavigationBar(self, title: "Все статьи", hasLeftItem: true)
    }

    func configureCollectionView() {
        articleListView.collectionView.dataSource = self
        articleListView.collectionView.delegate = self
    }

    @objc func searchTextChanged(_ textField: UITextField) {
        articleListViewModel.filterArticles(textField.text ?? "")
    }

    @objc func filterButtonTapped(_ button: UIButton) {
        let nextScreen = FilterViewController(view: FilterView(), viewModel: FilterViewModel())
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

extension ArticleListViewController: APIRequestDelegate {
    func onSucceedRequest() {
        DispatchQueue.main.async {
            self.applySnapshot(self.articleListViewModel.sections.count)
            self.articleListView.collectionView.reloadData()
        }
    }
    
    func onFailedRequest() {
        
    }
}

extension ArticleListViewController: FilterDelegate {
    func onSucceedFilterRequest() {
        DispatchQueue.main.async {
            self.reloadDataSource(self.articleListViewModel.sections.count)
            if self.articleListViewModel.sections.count == 0 {
                self.articleListView.bringSubviewToFront(self.articleListView.emptyStackView)
            } else {
                self.articleListView.bringSubviewToFront(self.articleListView.collectionView)
            }
        }
    }
    
    func onFailedFilterRequest() {
        
    }
}

extension ArticleListViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArticleName = articleListViewModel.sections[indexPath.row].name
        let nextScreen = ArticleViewController(view: ArticleView(), viewModel: ArticleViewModel(), articleName: selectedArticleName)
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
}

extension ArticleListViewController: NavigationManagerDelegate{
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ArticleListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as! ArticleCell
        let article = self.articleListViewModel.sections[indexPath.row]
        let color = self.articleListViewModel.colorsHex.randomElement()
            
        cell.configure(article, color ?? 0)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ArticleCellHeader.reuseIdentifier, for: indexPath) as! ArticleCellHeader
        headerView.searchField.addTarget(self, action: #selector(self.searchTextChanged(_:)), for: .editingChanged)
        headerView.filterButton.addTarget(self, action: #selector(self.filterButtonTapped(_:)), for: .touchUpInside)
        return headerView
    }
}

extension ArticleListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension ArticleListViewController {
    func reloadDataSource(_ countItems: Int) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.first])
        for i in 0..<countItems {
            snapshot.appendItems(["\(i)"], toSection: .first)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func applySnapshot(_ countItems: Int) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.first])
        for i in 0..<countItems {
            snapshot.appendItems(["\(i)"], toSection: .first)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: articleListView.collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            self.collectionView(collectionView, cellForItemAt: indexPath)
        })

        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            self.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
    }
}
