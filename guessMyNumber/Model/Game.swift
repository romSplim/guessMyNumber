//
//  Game.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 12.05.2022.
//

import Foundation

class Game {
    var typedNumber = 0
    var guessNumber = 0
    var minValue = 0
    var maxValue = 100
    var tryCount = 0
    var answer: Answer!
    var isGameEnded: Bool {
        guessNumber == typedNumber
    }

    init(number: Int) {
        self.typedNumber = number
        startGame()
    }
    
    init() {
        startPlayerGame()
    }
    
    func getAnswer() -> Answer {
        if guessNumber < typedNumber {
            return .greaterThen
        } else if guessNumber > typedNumber {
            return .lessThen
        } else {
            return .equal
        }
    }
    
    func compGenerateNumber() -> Int {
        (1...100).randomElement()!
    }
    
    func generateNumber() -> Int {
        let diff = maxValue - minValue
        return maxValue - (diff / 2)
    }
    
    func goNextTry() {
        tryCount += 1
    }
    
    func startGame() {
        goNextTry()
        guessNumber = generateNumber()
    }
    
    func startPlayerGame() {
        goNextTry()
        typedNumber = compGenerateNumber()
    }
    
    func updateMinValue() {
        minValue = guessNumber
    }
    
    func updateMaxValue() {
        maxValue = guessNumber
    }
}

extension Game {
    enum Answer: String {
        case lessThen = "Загаданное число меньше чем ваше"
        case greaterThen = "Загаданное число больше чем ваше"
        case equal = "Вы угадали число!"
    }
}
