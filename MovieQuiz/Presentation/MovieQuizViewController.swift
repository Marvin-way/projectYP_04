import UIKit

final class MovieQuizViewController: UIViewController {
    @IBOutlet weak var calculationHistory: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    var count = 0
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = "0"
        calculationHistory.text = "История изменений:"
    }
    
    func time() -> String{
        let now = DateFormatter()
        now.dateStyle = .short
        now.timeStyle = .short
        return now.string(from: Date())
    }
    @IBAction func buttonPlus(_ sender: Any) {
        count += 1
        countLabel.text = "\(count)"
        calculationHistory.text += "\n\(time()) значение изменено на +1"
    }
    @IBAction func buttonMinus(_ sender: Any) {
        if (count != 0){
            count -= 1
            countLabel.text = "\(count)"
            calculationHistory.text += "\n\(time()) значение изменено на -1"
        } else {
            calculationHistory.text += "\n\(time()) попытка уменьшить значение счётчика ниже 0"
        }
    }
    
    @IBAction func clearResult(_ sender: UIButton) {
        countLabel.text = "0"
        calculationHistory.text += "\n\(time()) значение сброшено"
    }
    
}

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
*/
