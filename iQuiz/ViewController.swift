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

    
    //settings alert for inserting a custom json file
    //reference for text field in alert controller https://stackoverflow.com/questions/29808380/swift-insert-alert-box-with-text-input-and-store-text-input
    @IBAction func settingsPress(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Insert a file you would like to load.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let file: String = alert.textFields![0].text!
            
            //set the subjects array to empty before populating it with a new file
            self.subjects = []
            UserDefaults.standard.set(file, forKey: "quiz_preference")
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
    //parses the json file to insert the quizzes and questions
    func getJSON(urlString:String){
        let url = URL(string: urlString)
        if Reachability.isConnectedToNetwork() == true {
            URLSession.shared.dataTask(with:url!) { (data, response, error) in
                if error != nil { //throw error if JSON can't be grabbed from the URL
                    let alert = UIAlertController(title: "Custom quiz file", message: "Download failed.", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(confirmAction)
                    self.getJSON(urlString: "https://tednewardsandbox.site44.com/questions.json")
                    self.present(alert, animated: true, completion: nil)
                } else {
                    do {
                        //get the JSON data
                        let response = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
                        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
                        //store the file locally
                        try response?.write(to: path)
                        
                        self.iterateJSON(jsonData: response!)
                    } catch {
                        //throw an error if the data from the URL cannot be grabbed
                        let alert = UIAlertController(title: "Custom quiz file", message: "Download failed.", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(confirmAction)
                        self.getJSON(urlString: "https://tednewardsandbox.site44.com/questions.json")
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                }.resume()
        } else { //not connected to internet, load local storage json file
            DispatchQueue.main.async{
                let alert = UIAlertController(title: "No internet connection", message: "Connect your device to the internet.", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(confirmAction)
                
                self.loadLocal()
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //loads the locally stored json file
    func loadLocal() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
        let jsonData = NSArray(contentsOf: path)!

        iterateJSON(jsonData: jsonData)
    }
    
    func iterateJSON(jsonData: NSArray) {
        //iterate through the data to populate the table
        let quizDetails = jsonData as? [[String: Any]] ?? []
        for subject in quizDetails {
            let subjectJSON = Subject(subjectName: subject["title"] as! String, subjectDesc: subject["desc"] as! String, questions: [])
            let questions = subject["questions"] as! [[String: Any]]
            for question in questions {
                subjectJSON.questions.append(Question(questionText: question["text"] as! String, choices: question["answers"] as! [String] , answer: question["answer"] as! String))
            }
            self.subjects.append(subjectJSON)
        }
        //reload table with quiz data
        DispatchQueue.main.async{
            self.tblQuiz.reloadData()
        }
    }
    
    //reference for settings bundle https://makeapppie.com/2016/03/14/using-settings-bundles-with-swift/
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    //Get the defaults from the application settings
    func updateDisplayFromDefaults(alert: UIAlertController){
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
        
        //get any saved url from the application settings
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

