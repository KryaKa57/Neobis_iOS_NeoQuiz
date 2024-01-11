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

        configureCollectionView()
        configureDataSource()
    }
    
    init(view: MainView, viewModel: MainViewModel) {
        mainViewModel = viewModel
        mainView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCollectionView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.addSubview(mainView.collectionView)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: mainView.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch (Section.allCases[indexPath.section]) {
            case .first:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstSectionCell.reuseIdentifier, for: indexPath) as! FirstSectionCell
                let article = self.mainViewModel.firstSectionViewModel.sections[indexPath.row]
                let color = self.mainViewModel.firstSectionViewModel.colorsHex.randomElement()
                
                cell.configure(article.name, article.subjectName, article.imageName, color ?? 0)
                return cell
            case .second:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondSectionCell.reuseIdentifier, for: indexPath) as! SecondSectionCell
                let quiz = self.mainViewModel.secondSectionViewModel.sections[indexPath.row]
                let color = self.mainViewModel.secondSectionViewModel.colorsHex[indexPath.row % self.mainViewModel.secondSectionViewModel.colorsHex.count]
                
                cell.configure(quiz.subjectName, quiz.countQuestion, quiz.imageName, color )
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as! SectionHeader
            headerView.configure(title: indexPath.section == 0 ? "Cтатьи" : "Квизы")
            return headerView
        }

        // Apply initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.first, .second])
        snapshot.appendItems(["dummy1", "dummy2", "dummy5", "dummy6"], toSection: .first)
        snapshot.appendItems(["dummy3", "dummy4", "dummy7", "dummy8"], toSection: .second)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstSectionCell.reuseIdentifier, for: indexPath) as! FirstSectionCell
            // Configure your first section cell using viewModel.firstSectionViewModel
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondSectionCell.reuseIdentifier, for: indexPath) as! SecondSectionCell
            // Configure your second section cell using viewModel.secondSectionViewModel
            return cell
        }
    }
}
