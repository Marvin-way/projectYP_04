//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Данис Байрамгулов on 15.01.2026.
//

import Foundation

protocol StatisticServiceProtocol {
    var gamesCount: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
    func store(correct count: Int, total amount: Int)
}
