//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Alexis Koss on 2/8/18.
//  Copyright © 2018 Alexis Koss. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var subject: Subject?
    var answerSelected = 0;
    var questionNumber = 0;
    var numberCorrect = 0;
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    @IBOutlet weak var answerChoiceOne: UIButton!
    @IBOutlet weak var answerChoiceTwo: UIButton!
    @IBOutlet weak var answerChoiceThree: UIButton!
    @IBOutlet weak var answerChoiceFour: UIButton!

    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func pressAnswerOne(_ sender: UIButton) {
        if answerChoiceOne.isSelected {
            answerChoiceOne.isSelected = false
            submitButton.isEnabled = false
        } else {
            answerChoiceOne.isSelected = true
            answerSelected = 0;
            answerChoiceTwo.isSelected = false
            answerChoiceThree.isSelected = false
            answerChoiceFour.isSelected = false
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func pressAnswerTwo(_ sender: UIButton) {
        if answerChoiceTwo.isSelected {
            answerChoiceTwo.isSelected = false
            submitButton.isEnabled = false
        } else {
            answerChoiceTwo.isSelected = true
            answerSelected = 1;
            answerChoiceOne.isSelected = false
            answerChoiceThree.isSelected = false
            answerChoiceFour.isSelected = false
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func pressAnswerThree(_ sender: UIButton) {
        if answerChoiceThree.isSelected {
            answerChoiceThree.isSelected = false
            submitButton.isEnabled = false
        } else {
            answerChoiceThree.isSelected = true
            answerSelected = 2;
            answerChoiceTwo.isSelected = false
            answerChoiceOne.isSelected = false
            answerChoiceFour.isSelected = false
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func pressAnswerFour(_ sender: UIButton) {
        if answerChoiceFour.isSelected {
            answerChoiceFour.isSelected = false
            submitButton.isEnabled = false
        } else {
            answerChoiceFour.isSelected = true
            answerSelected = 3;
            answerChoiceTwo.isSelected = false
            answerChoiceOne.isSelected = false
            answerChoiceThree.isSelected = false
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func submitPress(_ sender: UIButton) {
        let AnswerViewController = self.storyboard?.instantiateViewController(withIdentifier: "AnswerViewController") as! AnswerViewController
        AnswerViewController.subject = self.subject 
        AnswerViewController.questionNumber = self.questionNumber
        AnswerViewController.numberCorrect = self.numberCorrect
        AnswerViewController.answerSelected = self.answerSelected
        self.present(AnswerViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonLabel.text = "Q #\(questionNumber + 1): " + (subject?.questions[questionNumber].questionText)!
        answerChoiceOne.setTitle(subject?.questions[questionNumber].choices[0], for: .normal)
        answerChoiceTwo.setTitle(subject?.questions[questionNumber].choices[1], for: .normal)
        answerChoiceThree.setTitle(subject?.questions[questionNumber].choices[2], for: .normal)
        answerChoiceFour.setTitle(subject?.questions[questionNumber].choices[3], for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
