//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Данис Байрамгулов on 11.01.2026.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
