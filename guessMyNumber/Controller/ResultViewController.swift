//
//  ResultViewController.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 14.05.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    var gameResult: GameResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        mainMenuButton.layer.cornerRadius = mainMenuButton.frame.height / 2
    }
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Счет"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var urResultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Вам потребовалось \(gameResult.urTryCount) попыток"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var compResultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Компьютеру потребовалось \(gameResult.compTryCount) попыток"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var whoWinLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "\(gameResult.gameStatus)"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var mainMenuButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Главное меню", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    @objc func menuButtonPressed() {
        let mainMenuVC = StartGameViewController()
        mainMenuVC.modalPresentationStyle = .fullScreen
        self.present(mainMenuVC, animated: true)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                                     scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     urResultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     urResultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
                                     urResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     compResultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     compResultLabel.topAnchor.constraint(equalTo: urResultLabel.topAnchor, constant: 30),
                                     compResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     whoWinLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     whoWinLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     whoWinLabel.bottomAnchor.constraint(equalTo: mainMenuButton.bottomAnchor, constant: -60),
                                     
                                     mainMenuButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
                                     mainMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     mainMenuButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                                     mainMenuButton.heightAnchor.constraint(equalToConstant: 50),
                                    ])
    }
}
