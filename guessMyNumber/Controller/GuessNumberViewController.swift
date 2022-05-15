//
//  GuessNumberViewController.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 12.05.2022.
//

import UIKit

class GuessNumberViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstaints()
        view.backgroundColor = .systemBackground
        enterNumberButton.setState(isEnabled: false)
        dismissKeyboardByTap()
    }
    
    override func viewDidLayoutSubviews() {
        enterNumberButton.layer.cornerRadius = enterNumberButton.frame.height * 0.5
    }
    
    func dismissKeyboardByTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func enterButtonPressed() {
        guard let typedNumber = guessNumberTextField.text else { return }
        let compGuessingVC = ComputerGuessingViewController(number: Int(typedNumber) ?? 100)
        compGuessingVC.modalPresentationStyle = .fullScreen
        present(compGuessingVC, animated: true)
    }
    
    lazy var enterNumberButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Загадать число", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        return button
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
    
    func setConstaints() {
        NSLayoutConstraint.activate([
            enterNumberButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            enterNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterNumberButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            enterNumberButton.heightAnchor.constraint(equalToConstant: 50),
            
            guessNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            guessNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessNumberTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
            guessNumberTextField.heightAnchor.constraint(equalToConstant: 40)])
    }
}
//MARK: - UITexFieldDelegate methods

extension GuessNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        enterNumberButton.updateState(text: text)
        guard let intText = Int(text),
              !(1...100).contains(intText) else { return (string.rangeOfCharacter(from: invalidCharacters) == nil) }
        
        return false
    }
}


