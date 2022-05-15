//
//  PlayerGuessingViewController.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 13.05.2022.
//

import UIKit

class PlayerGuessingViewController: UIViewController {
    var game: Game!
    var results: GameResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        checkNumberButton.setState(isEnabled: false)
        game = Game()
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        checkNumberButton.layer.cornerRadius = checkNumberButton.frame.height * 0.5
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
        label.text = "Вы угадываете"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var miniAnswerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var guessNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Ввести число"
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        return textField
    }()
    
    lazy var checkNumberButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Проверить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    @objc func checkButtonPressed() {
        guard let number = Int(guessNumberTextField.text ?? "") else { return }
        game.guessNumber = number
        if game.isGameEnded {
            showGameEndedAlert()
        } else {
            game.goNextTry()
            miniAnswerLabel.text = game.getAnswer().rawValue
            triesLabel.text = "Попытка \(game.tryCount)"
        }
    }
    
    func saveResult() {
        self.results.urTryCount = game.tryCount
    }
    
    func showGameEndedAlert() {
        let alert = UIAlertController(title: "Ваш ход окончен", message: "Вы угадали число с \(game.tryCount) попытки", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Показать результаты", style: .default) { action in
            let resultVC = ResultViewController()
            self.saveResult()
            resultVC.gameResult = self.results
            resultVC.modalPresentationStyle = .fullScreen
            self.present(resultVC, animated: true)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([triesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     triesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                                     triesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     whoGuessLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     whoGuessLabel.topAnchor.constraint(equalTo: triesLabel.topAnchor, constant: 40),
                                     whoGuessLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     
                                     guessNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     guessNumberTextField.topAnchor.constraint(equalTo: whoGuessLabel.topAnchor, constant: 50),
                                     guessNumberTextField.heightAnchor.constraint(equalToConstant: 40),
                                     guessNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                                     
                                     checkNumberButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
                                     checkNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     checkNumberButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
                                     checkNumberButton.heightAnchor.constraint(equalToConstant: 50),
                                     
                                     miniAnswerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     miniAnswerLabel.topAnchor.constraint(equalTo: checkNumberButton.topAnchor, constant: 75),
                                     miniAnswerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                    ])
    }
}

//MARK: - UITexFieldDelegate methods

extension PlayerGuessingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (guessNumberTextField.text! as NSString).replacingCharacters(in: range, with: string)
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        checkNumberButton.updateState(text: text)
        guard let intText = Int(text),
              !(1...100).contains(intText) else { return (string.rangeOfCharacter(from: invalidCharacters) == nil) }
        
        return false
    }
}
