//
//  NavigationManager.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 12.01.2024.
//

import Foundation
import UIKit

protocol NavigationManagerDelegate: AnyObject {
    func backButtonTapped()
}

class NavigationManager {
    weak var delegate: NavigationManagerDelegate?
    
    func setupNavigationBar(_ vc: UIViewController, title: String = "",
                            hasLeftItem: Bool = false,
                            hasRightItem: Bool = false) {
        vc.navigationItem.setHidesBackButton(true, animated: true)
        if title != "" {
            vc.navigationItem.titleView = CustomTitleView(title)
        }
        
        if hasLeftItem {
            let leftButtonItem = getLeftItem()
            vc.navigationItem.leftBarButtonItem = leftButtonItem
        }
        
        if hasRightItem {
            let rightButtonItem = getRightItem()
            vc.navigationItem.rightBarButtonItem = rightButtonItem
        }
    }
    
    func getLeftItem() -> UIBarButtonItem {
        let leftButton: UIButton = {
            let button = UIButton()
            let image = UIImage(systemName: "arrow.left",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold))
            button.setImage(image, for: .normal)
            button.tintColor = .black
            button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
            return button
        }()
        
        return UIBarButtonItem(customView: leftButton)
    }
    
    func getRightItem() -> UIBarButtonItem {
        let rightButton: UIButton = {
            let button = UIButton()
            let image = UIImage(systemName: "xmark",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
            button.setImage(image, for: .normal)
            button.tintColor = .black
            button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
            return button
        }()
        
        return UIBarButtonItem(customView: rightButton)
    }
    
    @objc func leftButtonTapped() {
        delegate?.backButtonTapped()
    }
    
}
