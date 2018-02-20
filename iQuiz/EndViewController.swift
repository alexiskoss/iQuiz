//
//  EndViewController.swift
//  iQuiz
//
//  Created by Alexis Koss on 2/19/18.
//  Copyright © 2018 Alexis Koss. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    var subject: Subject?
    var numberCorrect: Int = 0;
    var correctPercentage: Float = 0.0;
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var numberCorrectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //check to see if optional value will return nil, if it does return nothing, else return the value I want for total # of questions
        //gets rid of the problem of having "optional(#)" displaying in my code
        //I just want the number, no extraneous text
        guard let totalQuestions = subject?.questions.count else {
            return
        }
        numberCorrectLabel.text = "You got \(numberCorrect)/\(totalQuestions)"
        correctPercentage = Float(numberCorrect)/Float(totalQuestions)
        NSLog(String(correctPercentage));
        
        if(correctPercentage == 1) {
            displayLabel.text = "Perfect! You got all the questions correct."
        } else if (correctPercentage >= 0.75 && correctPercentage < 1) {
            displayLabel.text = "Almost! You missed some questions."
        } else if (correctPercentage >= 0.50 && correctPercentage < 0.75 ) {
            displayLabel.text = "You're getting there! Try again."
        } else {
            displayLabel.text = "You really should try harder..."
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
