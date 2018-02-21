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
    var url: String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    //fill the table with the subjects
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let subjectName = subjects[indexPath.row].subjectName
        let subjectDesc = subjects[indexPath.row].subjectDesc
        
        cell.textLabel?.text = subjectName
        cell.detailTextLabel?.text = subjectDesc
        cell.imageView?.image = UIImage(named: subjectName)
        
        return cell
    }
    
    //once you click on a subject, go to a view of the QuestionViewController that has the state of that respective subject
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let QuestionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        QuestionViewController.subject = self.subjects[indexPath.row]
        self.present(QuestionViewController, animated: true, completion: nil)
    }

    //settings alert
    //reference for text field in alert controller https://stackoverflow.com/questions/29808380/swift-insert-alert-box-with-text-input-and-store-text-input
    @IBAction func settingsPress(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Insert a file you would like to load.", preferredStyle: .alert)
        
        /*alert.addAction(UIAlertAction(title: NSLocalizedString("Check now", comment: "Default action"), style: .`default`, handler: { _ in
        }))*/
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let file: String = alert.textFields![0].text!
            print("FILE ----> " + file)
            self.url = file
            //https://raw.githubusercontent.com/alexiskoss/iQuiz/master/questions.json
            self.subjects = []
            UserDefaults.standard.set(self.url, forKey: "quiz_preference")
            self.getJSON(urlString: file)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "URL here"
        }
        updateDisplayFromDefaults(alert: alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    //reference for json parsing from url https://stackoverflow.com/questions/42130002/post-data-and-get-data-from-json-url-in-swift
    //URLSession method
    func getJSON(urlString:String){
        let url = URL(string: urlString)
        if Reachability.isConnectedToNetwork() == true {
            URLSession.shared.dataTask(with:url!) { (data, response, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Custom quiz file", message: "Download failed.", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(confirmAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    do {
                        let response = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
                        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
                        try response?.write(to: path)
                        
                        let quizDetails = response as? [[String: Any]] ?? []
                        for subject in quizDetails {
                            //subjects.append(subject)
                            //print("SUBJECT!!!!!------> \(String(describing: subject["questions"]))")
                            let subjectJSON = Subject(subjectName: subject["title"] as! String, subjectDesc: subject["desc"] as! String, questions: [])
                            let questions = subject["questions"] as! [[String: Any]]
                            //let questions = arrayOfDetails![0]["questions"] as! [[String: Any]]
                            for question in questions {
                                //print("QUESTION!!!!---> \(question)")
                                subjectJSON.questions.append(Question(questionText: question["text"] as! String, choices: question["answers"] as! [String] , answer: question["answer"] as! String))
                            }
                            //print(subjectJSON)
                            self.subjects.append(subjectJSON)
                            //print(self.subjects)
                            //stored JSON locally
                        }
                        //store JSON locally
                        //response!.write(toFile: NSHomeDirectory() + "/Documents/data", atomically: true)


                        
                        print(NSHomeDirectory() + "/Documents")
                        
                        DispatchQueue.main.async{
                            self.tblQuiz.reloadData()
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
                }.resume()
        } else { //not connected to internet
            DispatchQueue.main.async{
                
                let alert = UIAlertController(title: "No internet connection", message: "Connect your device to the internet.", preferredStyle: .alert)
                
                let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(confirmAction)
                
                self.loadLocal()
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    func loadLocal() {
        print("yes")
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
        let jsonData = NSArray(contentsOf: path)!
        print(jsonData);
        
        let quizDetails = jsonData as? [[String: Any]] ?? []
        for subject in quizDetails {
            //subjects.append(subject)
            //print("SUBJECT!!!!!------> \(String(describing: subject["questions"]))")
            let subjectJSON = Subject(subjectName: subject["title"] as! String, subjectDesc: subject["desc"] as! String, questions: [])
            let questions = subject["questions"] as! [[String: Any]]
            //let questions = arrayOfDetails![0]["questions"] as! [[String: Any]]
            for question in questions {
                //print("QUESTION!!!!---> \(question)")
                subjectJSON.questions.append(Question(questionText: question["text"] as! String, choices: question["answers"] as! [String] , answer: question["answer"] as! String))
            }
            //print(subjectJSON)
            self.subjects.append(subjectJSON)
            //print(self.subjects)
            //stored JSON locally
            
            DispatchQueue.main.async{
                self.tblQuiz.reloadData()
            }
        
        }
    }

    
    //reference for settings bundle https://makeapppie.com/2016/03/14/using-settings-bundles-with-swift/
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    func updateDisplayFromDefaults(alert: UIAlertController){
        //Get the defaults
        let defaults = UserDefaults.standard
        if let quizURL = defaults.string(forKey: "quiz_preference"){
            alert.textFields![0].text! = quizURL
        } else{
            alert.textFields![0].text! = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerSettingsBundle()
        //UserDefaults.standard.set(url, forKey: "quiz_preference")
        if(UserDefaults.standard.string(forKey: "quiz_preference") != nil) {
            url = UserDefaults.standard.string(forKey: "quiz_preference")!
        } else {
            url = "https://tednewardsandbox.site44.com/questions.json"
        }
        getJSON(urlString: url)

        
        //load the initial table
        tblQuiz.dataSource = self
        tblQuiz.delegate = self
        tblQuiz.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

