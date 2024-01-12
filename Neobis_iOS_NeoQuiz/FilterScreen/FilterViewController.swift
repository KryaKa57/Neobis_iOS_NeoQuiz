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

