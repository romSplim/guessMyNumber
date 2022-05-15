//
//  StartGameViewController.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 12.05.2022.
//

import UIKit

class StartGameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setConstaints()
    }
    
    override func viewDidLayoutSubviews() {
        startGameButton.layer.cornerRadius = startGameButton.frame.height * 0.5
    }
    
    lazy var startGameButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Начать игру", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    lazy var startTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Моя кринжовая игра"
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    func setConstaints() {
        NSLayoutConstraint.activate([
            startGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            startGameButton.heightAnchor.constraint(equalToConstant: 50),
            
            startTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startTitleLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 85),
            startTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startTitleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)])
    }
    
    @objc func startButtonTapped() {
        let guessNumberVC = GuessNumberViewController()
        guessNumberVC.modalPresentationStyle = .fullScreen
        present(guessNumberVC, animated: true)
    }
}
