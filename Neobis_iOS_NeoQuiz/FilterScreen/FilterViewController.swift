//
//  FilterViewController.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {

    let filterView: FilterView
    let filterViewModel: FilterViewModel
    let navigationManager = NavigationManager()
    
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
    
    init(view: FilterView, viewModel: FilterViewModel) {
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
        cell.titleLabel.text = filterViewModel.genres[indexPath.row]
        cell.checkboxButton.isSelected = filterViewModel.selectedItems[indexPath.row]
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }

    func checkboxCell(_ cell: CheckboxTableViewCell, didChangeValue value: Bool) {
        if let indexPath = filterView.tableView.indexPath(for: cell) {
            filterViewModel.selectedItems[indexPath.row] = value
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0 // Set your desired cell height (including spacing)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "Категория:"
        titleLabel.textColor = .black
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let clearButton = UIButton(type: .system)
        let attributes = [
                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                            NSAttributedString.Key.font: UIFont(name: "Nunito-Bold", size: 16)
        ] as [NSAttributedString.Key : Any]
            
        clearButton.setAttributedTitle(NSAttributedString(string: "Clear Selection", attributes: attributes), for: .normal)
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
        clearButton.contentHorizontalAlignment = .left
        
        footerView.addSubview(clearButton)
        clearButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        return footerView
    }

    @objc func didTapClearButton() {
        // Clear selected items
        filterViewModel.selectedItems = Array(repeating: false, count: filterViewModel.genres.count)
        filterView.tableView.reloadData()
    }
    
}
