//
//  ViewController.swift
//  iQuiz
//
//  Created by Alexis Koss on 2/7/18.
//  Copyright © 2018 Alexis Koss. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tblQuiz: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let subjectName = subjects[indexPath.row]
        
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = "\(subjectName) is so much fun to learn!"
        cell.imageView?.image = UIImage(named: subjectName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    @IBAction func settingsPress(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblQuiz.dataSource = self
        tblQuiz.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

