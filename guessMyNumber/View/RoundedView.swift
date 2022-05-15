//
//  RoundedButton.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 13.05.2022.
//

import UIKit

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 4
    }
}
