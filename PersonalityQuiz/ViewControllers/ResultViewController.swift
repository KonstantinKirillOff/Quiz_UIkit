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
    
    var answers: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        showResult()
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func showResult() {
        let youAnimal = findResult()
        if let resultAnimal = youAnimal {
            youLabel.text = "Вы - \(resultAnimal.rawValue)"
            descriptionLabel.text = resultAnimal.definition
        }
    }
    
    private func findResult() -> Animal? {
        var chosenAnimal: [Animal : Int] = [:]
        let animals = answers.map { $0.animal }
        
        animals.forEach { animal in
            let countAnsvers = howManyTimes(in: answers, count: animal)
            chosenAnimal[animal] = countAnsvers
        }
        
        let sortedDict = chosenAnimal.sorted { $0.value > $1.value }
        guard let resultAnimal = sortedDict.first?.key else { return nil }
        
        return resultAnimal
    }
    
    
    private func howManyTimes(in answers: [Answer], count: Animal) -> Int {
        return answers.reduce(0) {
            $1.animal == count ? $0 + 1 : $0
        }
    }
}
