//
//  ScoreViewController.swift
//  millionaireApp.practice.week4
//
//  Created by Fatima Abdinli on 26.12.23.
//

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var name: String?
    private var age: Int?
    private var score: Int?
    private var questionCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setData(_ name: String, _ age: Int, _ questionCount: Int, _ score: Int) {
        self.name = name
        self.age = age
        self.questionCount = questionCount
        self.score = score
    }
    
    func setupView() {
        nameLabel.text = "Name: \(name ?? "")"
        
        let safeAge = age ?? 0;
        
        if safeAge > 0 {
            ageLabel.text = "Age: \(safeAge)"
        } else {
            ageLabel.text = "Age: N/A"
        }

        scoreLabel.text = "Your score is \(score ?? 0) out of \(questionCount ?? 0)"
        let percentage = Double(score!)  * 100 / Double(questionCount!)
        if percentage > 50 {
            resultLabel.text = "You passed the exam"
        } else {
            resultLabel.text = "You failed the exam"
        }
    }
}
