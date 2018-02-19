//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Alexis Koss on 2/8/18.
//  Copyright © 2018 Alexis Koss. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

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
            answerChoiceTwo.isSelected = false
            answerChoiceThree.isSelected = false
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
            answerChoiceTwo.isSelected = false
            answerChoiceOne.isSelected = false
            answerChoiceFour.isSelected = false
            submitButton.isEnabled = true
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
