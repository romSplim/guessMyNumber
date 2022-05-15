//
//  GameResult.swift
//  guessNumber
//
//  Created by Рамиль Ахатов on 14.05.2022.
//

import Foundation

struct GameResult {
    var compTryCount = 0
    var urTryCount = 0
    var gameStatus: String {
        getStatus().rawValue
    }
    
    init(compTryCount: Int) {
        self.compTryCount = compTryCount
    }
    
    private func getStatus() -> Status {
        if urTryCount < compTryCount {
            return .win
        } else if urTryCount > compTryCount {
            return .lose
        } else {
            return .deadHeat
        }
    }
}

extension GameResult {
    enum Status: String {
        case win = "Вы победили🏆"
        case lose = "Вы проиграли😿"
        case deadHeat = "Ничья😲"
    }
}
