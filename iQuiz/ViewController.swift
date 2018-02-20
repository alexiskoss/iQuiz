//
//  ViewController.swift
//  iQuiz
//
//  Created by Alexis Koss on 2/7/18.
//  Copyright © 2018 Alexis Koss. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tblQuiz: UITableView!
    var subjects: [Subject] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let subjectName = subjects[indexPath.row].subjectName
        let subjectDesc = subjects[indexPath.row].subjectDesc
        
        cell.textLabel?.text = subjectName
        cell.detailTextLabel?.text = subjectDesc
        cell.imageView?.image = UIImage(named: subjectName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let QuestionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        QuestionViewController.subject = self.subjects[indexPath.row]
        self.present(QuestionViewController, animated: true, completion: nil)
    }

    @IBAction func settingsPress(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblQuiz.dataSource = self
        tblQuiz.delegate = self
        tblQuiz.tableFooterView = UIView()
        
        
        //define questions
        let mQ1 = Question(questionText: "What is 2 + 22?", choices: ["20", "18", "2", "24"], answer: 3)
        let mQ2 = Question(questionText: "What is -3 + (-11)?", choices: ["-14", "8", "14", "-8"], answer: 0)
        let mQ3 = Question(questionText: "What is 2 * 80?", choices: ["180", "160", "80", "82"], answer: 1)
            
        let marQ1 = Question(questionText: "Who is not a Marvel super hero?", choices: ["Spiderman", "Wonder Woman", "Wolverine", "Hulk"], answer: 1)
        let marQ2 = Question(questionText: "Which Marvel super hero does Tobey Maguire play?", choices: ["Hulk", "Iron Man", "Daredevil", "Spiderman"], answer: 3)
            
        let sQ1 = Question(questionText: "In our solar system, which planet has the shortest day?", choices: ["Jupiter", "Pluto", "Earth", "Mars"], answer: 0)
        let sQ2 = Question(questionText: "How many time zones are there in the world?", choices: ["12", "8", "24", "5"], answer: 2)
        let sQ3 = Question(questionText: "What is the first element on the periodic table?", choices: ["Oxygen", "Hydrogen", "Helium", "Chloride"], answer: 1)
        
        //define subjects
        let math = Subject(subjectName: "Mathematics", subjectDesc: "Ready to test your math skills?!", questions: [mQ1, mQ2, mQ3])
        let marvel = Subject(subjectName: "Marvel Super Heroes", subjectDesc: "How well do you really know your super heroes?", questions: [marQ1, marQ2])
        let science = Subject(subjectName: "Science", subjectDesc: "Do you got what it takes to be a scientist?", questions: [sQ1, sQ2, sQ3])
        
        //add completed subjects
        subjects = [math, marvel, science]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

