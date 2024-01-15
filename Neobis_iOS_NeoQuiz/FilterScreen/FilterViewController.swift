//
//  FilterViewController.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit

protocol GenreDelegate {
    func onGenreChanged(genre: [String])
}

class FilterViewController: UIViewController {

    let filterView: FilterView
    let filterViewModel: FilterViewModel
    var footerView: CheckboxTableFooter?
    let navigationManager = NavigationManager()
    var delegate: GenreDelegate?
    
    override func loadView() {
        view = filterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        addDelegates()
        filterView.tableView.reloadData()
        filterView.configureUI(filterViewModel.genres.count)
    }
    
    init(view: FilterView, viewModel: FilterViewModel, genres: [String], selectedGenres: [String]) {
        viewModel.getArrays(genres, selectedGenres)
        filterViewModel = viewModel
        filterView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDelegates() {
        filterView.tableView.delegate = self
        filterView.tableView.dataSource = self
        
        filterViewModel.getRequestDelegate = self
    }
    
    func setNavigation() {
        navigationManager.delegate = self
        navigationManager.setupNavigationBar(self, title: "", hasRightItem: true)
    }
}

extension FilterViewController: NavigationManagerDelegate{
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource, CheckboxTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterViewModel.genres.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckboxTableViewCell.reuseIdentifier, for: indexPath) as! CheckboxTableViewCell
        let genre = filterViewModel.genres[indexPath.row]
        cell.titleLabel.text = genre.prefix(1).uppercased() + genre.lowercased().dropFirst()
        cell.checkboxButton.isSelected = filterViewModel.selectedItems[indexPath.row]
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }

    func checkboxCell(_ cell: CheckboxTableViewCell, didChangeValue value: Bool) {
        if let indexPath = filterView.tableView.indexPath(for: cell) {
            filterViewModel.selectedItems[indexPath.row] = value
            
            let isAnyItemSelected = filterViewModel.selectedItems.contains(true)
            if let confirmButton = footerView?.confirmButton {
                confirmButton.isEnabled = isAnyItemSelected
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "Category:"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Nunito-Bold", size: 16)
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footerView = CheckboxTableFooter()
        footerView?.clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
        footerView?.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        
        return footerView
    }

    @objc func didTapClearButton() {
        filterViewModel.selectedItems = Array(repeating: false, count: filterViewModel.genres.count)
        filterView.tableView.reloadData()
    }
    
    @objc func didTapConfirmButton() {
        delegate?.onGenreChanged(genre: zip(filterViewModel.genres, filterViewModel.selectedItems)
                                        .compactMap { $1 ? $0 : nil })
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FilterViewController: APIRequestDelegate {
    func onFailedRequest() {
        
    }
    
    func onSucceedRequest() {
        DispatchQueue.main.async {
            self.filterView.tableView.reloadData()
        }
    }
}
