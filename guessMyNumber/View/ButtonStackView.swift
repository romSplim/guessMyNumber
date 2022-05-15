//
//  ButtonStackView.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 15.05.2022.
//

import UIKit

class ButtonStackView: UIStackView {
    
    init() {
        super.init(frame: .zero)
        setupStack()
        addSubviewsToStack()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var lessThenButton: RoundButton = {
        let button = RoundButton(type: .roundedRect)
        button.setTitle("<", for: .normal)
        return button
    }()
    
    var equalButton: RoundButton = {
        let button = RoundButton(type: .roundedRect)
        button.setTitle("=", for: .normal)
        return button
    }()
    
    var greaterThenButton: RoundButton = {
        let button = RoundButton(type: .roundedRect)
        button.setTitle(">", for: .normal)
        return button
    }()
    
    func setupStack() {
        axis = .horizontal
        spacing = 5
        alignment = .fill
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
        layoutSubviews()
    }
    
    func addSubviewsToStack() {
        [greaterThenButton, equalButton, lessThenButton].forEach { button in
            button.clipsToBounds = true
            button.tintColor = .systemGray
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.systemGray.cgColor
            addArrangedSubview(button)
        }
    }
}
