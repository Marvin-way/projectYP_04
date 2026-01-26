import UIKit

final class MovieQuizViewController: UIViewController {
    
    // MARK: - Types
    
    private var alertPresenter: AlertPresenter?
    private var currentQuestion: QuizQuestion?
    private var statisticService: StatisticService?
    private var presenter: MovieQuizPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        presenter = MovieQuizPresenter(viewController: self)
        alertPresenter = AlertPresenter(viewController: self)
        statisticService = StatisticService()
    }
        
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak private var counterLabel: UILabel!
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    func hideLoadingIndicator(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func showNetworkError(message: String) {
        
        hideLoadingIndicator()
        
        let model = AlertModel(title: "Ошибка",
                               message: message,
                               buttonText: "Попробовать еще раз") { [weak self] in
            guard let self = self else { return }
            
            self.presenter.restartGame()
        }
        
        alertPresenter?.show(model: model)
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
    private func setupImageView() {
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
    }
    
    func showAnswerResult(isCorrect: Bool) {
        //        yesButton.isEnabled = false
        //        noButton.isEnabled = false
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        if isCorrect == true {
            imageView.layer.borderColor = UIColor.ypGreen.cgColor
            presenter.correctAnswers += 1
        } else {
            imageView.layer.borderColor = UIColor.ypRed.cgColor
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.presenter.showNextQuestionOrResults()
            self.imageView.layer.borderWidth = 0
            //            self.yesButton.isEnabled = true
            //            self.noButton.isEnabled = true
        }
    }
    
    private func showCurrentQuestion() {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let step = presenter.convert(model: currentQuestion)
        show(quiz: step)
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.image = UIImage(data: step.image) ?? UIImage()
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func show(quiz result: QuizResultsViewModel) {
        if let statisticService = statisticService {
            statisticService
                .store(
                    correct: presenter.correctAnswers,
                    total: presenter.questionsAmount
                )
            
            let bestGame = statisticService.bestGame
            let bestGameDate = bestGame.date.dateTimeString
            let accuracy = "\(String(format: "%.2f", statisticService.totalAccuracy))%"
            
            
            let message: String = "Ваш результат: \(presenter.correctAnswers)/\(presenter.questionsAmount)\nКоличество сыгранных квизов: \(statisticService.gamesCount)\nРекорд: \(bestGame.correct)/\(bestGame.total) \(bestGameDate)\nСредняя точность: \(accuracy)"
            
            let model = AlertModel(
                title: result.title,
                message: message,
                buttonText: result.buttonText
            ) { [weak self] in
                guard let self else { return }
                self.presenter.resetQuestionIndex()
                self.showLoadingIndicator()
                self.presenter.restartGame()
            }
            
            alertPresenter?.show(model: model)
        }
    }
}
