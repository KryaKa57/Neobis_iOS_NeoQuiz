//
//  MainViewController.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 11.01.2024.
//

import UIKit

enum Section: Hashable, CaseIterable  {
    case first
    case second
}

class MainViewController: UIViewController {
    let mainView: MainView
    let mainViewModel: MainViewModel
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewModel.getQuizes()
        mainViewModel.getArticles()
        
        configureCollectionView()
        configureDataSource()
        addDelegates()
    }
    
    init(view: MainView, viewModel: MainViewModel) {
        mainViewModel = viewModel
        mainView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addDelegates() {
        mainViewModel.getRequestDelegate = self
    }
    
    func configureCollectionView() {
        mainView.collectionView.dataSource = dataSource
        mainView.collectionView.delegate = self
    }
}

extension MainViewController: APIRequestDelegate  {
    func onSucceedRequest() {
        DispatchQueue.main.async {
            self.applySnapshot(self.mainViewModel.firstSectionViewModel.sections.count,
                               self.mainViewModel.secondSectionViewModel.sections.count)
            self.mainView.collectionView.reloadData()
        }
    }
    
    func onFailedRequest() {
        
    }
}

extension MainViewController: NavigationDelegate  {
    func buttonTapped(_ section: Int) {
        if section == 0 {
            let nextScreen = ArticleListViewController(view: ArticleListView()
                                                       , viewModel: ArticleListViewModel())
            self.navigationController?.pushViewController(nextScreen, animated: true)
        } else {
            let nextScreen = QuizListViewController(view: QuizListView()
                                                           , viewModel: QuizListViewModel())
            self.navigationController?.pushViewController(nextScreen, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle cell selection here
        if indexPath.section == 0 {
            let selectedArticleName = mainViewModel.firstSectionViewModel.sections[indexPath.row].name
            let nextScreen = ArticleViewController(view: ArticleView(), viewModel: ArticleViewModel(), articleName: selectedArticleName)
            self.navigationController?.pushViewController(nextScreen, animated: true)
        } else {
            print(1)
        }
    }
}

extension MainViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: mainView.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch (Section.allCases[indexPath.section]) {
            case .first:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstSectionCell.reuseIdentifier, for: indexPath) as! FirstSectionCell
                let article = self.mainViewModel.firstSectionViewModel.sections[indexPath.row]
                let color = self.mainViewModel.firstSectionViewModel.colorsHex.randomElement()
                
                cell.configure(article, color ?? 0)
                
                return cell
            case .second:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondSectionCell.reuseIdentifier, for: indexPath) as! SecondSectionCell
                let quiz = self.mainViewModel.secondSectionViewModel.sections[indexPath.row]
                let color = self.mainViewModel.secondSectionViewModel.colorsHex[indexPath.row % self.mainViewModel.secondSectionViewModel.colorsHex.count]
                
                cell.configure(quiz, color)
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as! SectionHeader
            headerView.configure(title: indexPath.section == 0 ? "Cтатьи" : "Квизы"
                                 , sectionIndex: indexPath.section == 0 ? 0 : 1)
            headerView.delegate = self
            return headerView
        }
    }
    
    func applySnapshot(_ firstCountItems: Int, _ secondCountItems: Int) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.first, .second])
        for i in 0..<firstCountItems {
            snapshot.appendItems(["\(i)"], toSection: .first)
        }
        for i in 0..<secondCountItems {
            snapshot.appendItems(["\(firstCountItems+i)"], toSection: .second)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
