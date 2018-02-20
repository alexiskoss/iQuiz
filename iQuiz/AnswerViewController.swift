//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Alexis Koss on 2/19/18.
//  Copyright © 2018 Alexis Koss. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    var subject: Subject?
    var answerSelected = 0;
    var questionNumber = 0;
    var numberCorrect = 0;
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var wasItCorrectLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = "Q #\(questionNumber + 1): " + (subject?.questions[questionNumber].questionText)!
        correctAnswer.text = "The correct answer was " +  (subject?.questions[questionNumber].choices[(subject?.questions[questionNumber].answer)!])!
        if(answerSelected == subject?.questions[questionNumber].answer) {
            numberCorrect = numberCorrect + 1
            wasItCorrectLabel.text = "You were correct! You have guessed \(numberCorrect) right so far."
        } else {
            correctAnswer.backgroundColor = UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 0.6)
            wasItCorrectLabel.text = "Sorry, you got it wrong! You answered " + (subject?.questions[questionNumber].choices[(answerSelected)])!
        }
        questionNumber = questionNumber + 1
    }
    
    //reference on how to override where the segue goes https://stackoverflow.com/questions/26089024/swift-make-button-trigger-segue-to-new-scene
    @IBAction func nextButton(_ sender: UIButton) {
        if (questionNumber > (subject?.questions.count)!) {
            
        } else {
            self.performSegue(withIdentifier: "nextQ", sender: sender)
        }
    }
    
    //reference on how to override what data is passed via a segue https://learnappmaking.com/pass-data-view-controllers-swift-how-to/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is QuestionViewController) {
            let QuestionViewController = segue.destination as! QuestionViewController
            QuestionViewController.subject = self.subject
            QuestionViewController.questionNumber = self.questionNumber
            QuestionViewController.numberCorrect = self.numberCorrect
        }
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
