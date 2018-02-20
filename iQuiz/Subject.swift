//
//  Subject.swift
//  iQuiz
//
//  Created by Alexis Koss on 2/19/18.
//  Copyright © 2018 Alexis Koss. All rights reserved.
//

import UIKit

//creates a subject with questions
class Subject: NSObject {
    var subjectName: String = ""
    var subjectDesc: String = ""
    var questions: [Question] = []
    
    init(subjectName: String, subjectDesc: String, questions:[Question]) {
        self.subjectName = subjectName
        self.subjectDesc = subjectDesc
        self.questions = questions
    }
}
