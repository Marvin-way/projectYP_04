//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Данис Байрамгулов on 11.01.2026.
//

import Foundation

protocol QuestionFactoryProtocol {
    func setup(delegate: QuestionFactoryDelegate)
    func requestNextQuestion()
}
