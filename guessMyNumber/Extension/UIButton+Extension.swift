//
//  UIButton+Extension.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 13.05.2022.
//

import UIKit

extension UIButton {
    func setState(isEnabled: Bool) {
        self.isEnabled = isEnabled
        self.alpha = isEnabled ? 1.0 : 0.5
    }
    
    func updateState(text: String) {
        text.isEmpty ? setState(isEnabled: false) : setState(isEnabled: true)
    }
}
