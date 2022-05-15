//
//  ComputerGuessingViewController.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 12.05.2022.
//

import UIKit

class ComputerGuessingViewController: UIViewController {
    var game: Game!
    
    init(number: Int) {
        self.game = Game(number: number)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeConstraints()
        addTargetsToButtons()
    }
    
    func addTargetsToButtons() {
        buttonStackView.greaterThenButton.addTarget(self, action: #selector(greaterButtonTapped), for: .touchUpInside)
        buttonStackView.equalButton.addTarget(self, action: #selector(equalButtonTapped), for: .touchUpInside)
        buttonStackView.lessThenButton.addTarget(self, action: #selector(lessButtonTapped), for: .touchUpInside)
    }
    
    lazy var triesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Попытка \(game.tryCount)"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var whoGuessLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Компьютер угадывает"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var urNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Ваше число - \(game.guessNumber)?"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var myNumberIsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Моё число ..."
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var buttonStackView: ButtonStackView = {
        let stack = ButtonStackView()
        view.addSubview(stack)
        return stack
    }()
    
    func makeConstraints() {
        NSLayoutConstraint.activate([triesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     triesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                                     triesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     whoGuessLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     whoGuessLabel.topAnchor.constraint(equalTo: triesLabel.topAnchor, constant: 40),
                                     whoGuessLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     urNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     urNumberLabel.topAnchor.constraint(equalTo: whoGuessLabel.topAnchor, constant: 80),
                                     urNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     myNumberIsLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: buttonStackView.topAnchor, multiplier: -2),
                                     myNumberIsLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
                                     myNumberIsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                                     buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     buttonStackView.heightAnchor.constraint(equalTo: buttonStackView.widthAnchor, multiplier: 1/3),
                                     buttonStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5)
                                    ])
    }
    
    @objc func greaterButtonTapped() {
        if game.typedNumber < game.guessNumber || game.typedNumber == game.guessNumber {
            showHelpActionSheet()
        } else {
            game.updateMinValue()
            game.startGame()
            triesLabel.text = "Попытка \(game.tryCount)"
            urNumberLabel.text = "Ваше число - \(game.guessNumber)?"
        }
    }
    
    @objc func equalButtonTapped() {
        game.isGameEnded ? showGameEndedAlert() : showHelpActionSheet()
    }
    
    @objc func lessButtonTapped() {
        if game.typedNumber > game.guessNumber || game.typedNumber == game.guessNumber {
            showHelpActionSheet()
        } else {
            game.updateMaxValue()
            game.startGame()
            triesLabel.text = "Попытка \(game.tryCount)"
            urNumberLabel.text = "Ваше число - \(game.guessNumber)?"
        }
    }
    
    func saveGameResult() -> GameResult {
        return GameResult(compTryCount: game.tryCount)
    }
    
    func showGameEndedAlert() {
        let alert = UIAlertController(title: "Ход компьютера окончен", message: "Компьютер угадал число с \(game.tryCount) попытки", preferredStyle: .alert)
        let nextMove = action(with: "Переход хода")
        alert.addAction(nextMove)
        self.present(alert, animated: true)
    }
    
    func showHelpActionSheet() {
        let alert = UIAlertController(title: "Не та кнопка", message: "Вы загадали число \(game.typedNumber)", preferredStyle: .actionSheet)
        let action = okAction(with: "ОК")
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func action(with title: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { action in
            let playerGuessingVC = PlayerGuessingViewController()
            playerGuessingVC.results = self.saveGameResult()
            
            playerGuessingVC.modalPresentationStyle = .fullScreen
            self.present(playerGuessingVC, animated: true)
        }
    }
    
    func okAction(with title: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { action in
            
        }
    }
}
