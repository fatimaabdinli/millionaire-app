//
//  ViewController.swift
//  millionaireApp.practice.week4
//
//  Created by Fatima Abdinli on 12.12.23.
//

import UIKit
struct Person {
    var name: String?
    var mail: String?
    var age: Int?
}

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    var person: Person?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTarget()
    }
    
    fileprivate func setupTarget() {
        submitButton.addTarget(self, action: #selector(submitButtonTap), for: .touchUpInside)
    }
    
    fileprivate func setupView() {
        submitButton.layer.cornerRadius = 8
        
        nameTextField.keyboardType = .default
        mailTextField.keyboardType = .emailAddress
        ageTextField.keyboardType = .decimalPad
        
        nameTextField.returnKeyType = .done
        mailTextField.returnKeyType = .done
        ageTextField.returnKeyType = .done
        
        nameTextField.delegate = self
        mailTextField.delegate = self
        ageTextField.delegate = self
        
        nameTextField.placeholder = "Enter your name"
        mailTextField.placeholder = "Enter your email"
        ageTextField.placeholder = "Enter your age"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func submitButtonTap() {
        let name = nameTextField.text ?? ""
        let mail = mailTextField.text ?? ""
        let age = ageTextField.text ?? ""
        let ageInt = Int(age) ?? 0
        
        let isNameValid = name.count > 3
        let isMailValid = mail.count > 5
        let isAgeValid = !age.isEmpty
        
        if !isNameValid {
            nameTextField.layer.borderColor = UIColor.red.cgColor
            nameTextField.layer.borderWidth = 1.0
        }
        
        if !isMailValid {
            mailTextField.layer.borderColor = UIColor.red.cgColor
            mailTextField.layer.borderWidth = 1.0
        }
        
        if !isAgeValid {
            ageTextField.layer.borderColor = UIColor.red.cgColor
            ageTextField.layer.borderWidth = 1.0
        }
    
        if !isNameValid || !isMailValid || !isAgeValid {return}
    
        person = Person(name: name, mail: mail, age: ageInt)
        
        print("Successful log in", person ?? Person())
        showQuestionController()
}
    
    
    fileprivate func showQuestionController() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController
        guard let person = person else {return}
        vc?.setUser(person)
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.restorationIdentifier == "nameField" {
            mailTextField.becomeFirstResponder()
        } else if textField.restorationIdentifier == "emailField" {
            ageTextField.becomeFirstResponder()
        }
         return true
     }
    
    
    internal func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case nameTextField:
           if (textField.text?.count ?? 0) > 3 {
               nameTextField.layer.borderWidth = 0
           } else {
               nameTextField.layer.borderWidth = 1
               nameTextField.layer.borderColor = UIColor.red.cgColor
           }
        case mailTextField:
           if (textField.text?.count ?? 0) > 5 {
               mailTextField.layer.borderWidth = 0
           } else {
               mailTextField.layer.borderWidth = 1
               mailTextField.layer.borderColor = UIColor.red.cgColor
           }
        case ageTextField:
            if !(textField.text ?? "").isEmpty {
                ageTextField.layer.borderWidth = 0
            } else {
                ageTextField.layer.borderWidth = 1
                ageTextField.layer.borderColor = UIColor.red.cgColor
            }
            
        default:
            break
        }
    }
}



