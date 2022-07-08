//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Alexey Efimov on 30.08.2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var youLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // 1. Передать сюда массив с ответами
    // 2. Определить наиболее часто встречающийся тип животного
    // 3. Отобразить результат в соответствии с этим животным
    // 4. Избавиться от кнопки возврата на предыдущий экран
    
    var answers: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        showResult()
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func showResult() {
        let youAnimal = findResult()
        youLabel.text = "Вы - \(youAnimal.rawValue)"
        descriptionLabel.text = youAnimal.definition
    }
    
    private func findResult() -> Animal {
        var chosenAnimal: [Animal : Int] = [:]
        
        [Animal.cat, Animal.dog, Animal.rabbit, Animal.turtle].forEach { animal in
            let countAnsvers = howManyTimes(in: answers, count: animal)
            chosenAnimal[animal] = countAnsvers
        }
        
        let sortedDict = chosenAnimal.sorted(by: {$0.value > $1.value})
        
        return sortedDict.first!.key
    }
    
    
    private func howManyTimes(in answers: [Answer], count: Animal) -> Int {
        return answers.reduce(0) {
            $1.animal == count ? $0 + 1 : $0
        }
    }
}
