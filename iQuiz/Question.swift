//
//  Question.swift
//  iQuiz
//
//  Created by Alexis Koss on 2/19/18.
//  Copyright © 2018 Alexis Koss. All rights reserved.
//

import UIKit

//creates a question for a subject
class Question: NSObject {
    var questionText: String = ""
    var choices: [String] = []
    var answer: Int = 0
    
    init(questionText: String, choices: [String], answer: Int) {
        self.questionText = questionText
        self.choices = choices
        self.answer = answer
    }
}
