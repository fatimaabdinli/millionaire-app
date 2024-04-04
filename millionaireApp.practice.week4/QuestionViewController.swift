//
//  QuestionViewController.swift
//  millionaireApp.practice.week4
//
//  Created by Fatima Abdinli on 22.12.23.
//

import UIKit

struct Question {
    var questionText: String
    var choices: [String]
    var correctAnswer: String
}



var questions = [   Question(questionText: "Which is the capital of Azerbaijan:", choices: ["Baku", "Ganja",                      "Tabriz", "Guba"], correctAnswer: "Baku"),
                 Question(questionText: "What is the biggest city in the world?", choices: ["Moscow", "Tokio", "New York", "Delhi"], correctAnswer: "Tokio"),
                    Question(questionText: "What is the highest mountain in the world?", choices: ["Everest", "Kangchenjunga", "K2", "Lhotse"], correctAnswer: "Everest"),
                    Question(questionText: "Which is the lightest metal in elemental table?", choices: ["potassium", "lithium", "sodium", "copper"], correctAnswer: "lithium"),
                             Question(questionText: "Which planet has the most moons?", choices: ["Jupiter", "Neptun", "Earth", "Saturn"], correctAnswer: "Saturn")
                    ]

class QuestionViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!

    var questionIndex = 0
    var score = 0
    private var user: Person!
    private var tappedCell: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderLabel()
        setupQuestion()
        setupView()
        setupTarget()
    }
    
    func setUser(_ user: Person) {
        self.user = user
    }
    
    func setupHeaderLabel() {
        headerLabel.text = "Hello, \(user.name ?? "")!"
    }
    
    func setupQuestion() {
        questionLabel.text = questions[questionIndex].questionText
    }
    
    func setupView() {
        questionLabel.layer.cornerRadius = 12
//        ?????
    }
    
    func setupTarget() {
        submitButton.addTarget(self, action: #selector(submitButtonAction), for: .touchUpInside)
    }
    
    @objc func submitButtonAction() {
        if questionIndex == questions.count - 2 {
            submitButton.setTitle("Show results", for: .normal)
        }
        
        if questionIndex == questions.count - 1 {
            showResults()
        } else {
            questionIndex = questionIndex + 1
            setupQuestion()
            tappedCell = nil
            tableView.reloadData()
            tableView.allowsSelection = true
        }
    }
    
    fileprivate func showResults() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController
        vc?.setData(user.name ?? "", user.age ?? 0, questions.count, score)
        navigationController?.pushViewController(vc!, animated: true)
    }
}

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questions[questionIndex].choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell
        cell.answerLabel.text = questions[questionIndex].choices[indexPath.row]
        
        
        if tappedCell != nil {
            let chosenAnswer = questions[questionIndex].choices[indexPath.row]
            if (chosenAnswer == questions[questionIndex].correctAnswer) {
                cell.backgroundColor = UIColor(red: 0.0353, green: 0.7765, blue: 0, alpha: 1)
            } else {
                if tappedCell == indexPath.row {
                    cell.backgroundColor = UIColor(red: 0.8667, green: 0.1294, blue: 0, alpha: 1)
                }
            }
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tappedCell = indexPath.row
        tableView.reloadData()
        tableView.allowsSelection = false
        
        // check if the answer is correct
        if questions[questionIndex].correctAnswer == questions[questionIndex].choices[tappedCell!] {
            score = score + 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}






