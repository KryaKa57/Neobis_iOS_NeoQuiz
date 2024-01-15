//
//  CustomButton.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 14.01.2024.
//

import Foundation
import UIKit

enum ButtonStyle {
    case primary, secondary
    
    func getTitleColor() -> UIColor {(self == .primary) ? .white : UIColor(rgb: 0x5458EA)}
    func getBackgroundColor() -> UIColor {self == .primary ? .black : .white}
    
    func getBackgroundColorDisabled() -> UIColor {(self == .primary) ? UIColor(rgb: 0x939393) : UIColor(rgb: 0xF6F6F6)}
}

class CustomButton: UIButton {
    
    let padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 5)
    
    var textValue: String
    var style = ButtonStyle.primary
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = style.getBackgroundColor()
            } else {
                self.backgroundColor = style.getBackgroundColorDisabled()
            }
        }
    }
    
    required init(textValue: String, isPrimary: Bool = true) {
        self.textValue = textValue
        super.init(frame: .zero)
        style = isPrimary ? .primary : .secondary
        setup()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setup() {
        self.setTitle(textValue, for: .normal)
        self.titleLabel?.font = UIFont(name: "Nunito-Medium", size: 16)!
        self.setTitleColor(style.getTitleColor(), for: .normal)
        self.backgroundColor = style.getBackgroundColor()
        self.layer.cornerRadius = 12
    }
}
