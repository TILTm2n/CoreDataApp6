//
//  ViewController.swift
//  CoreDataApp6
//
//  Created by Eugene on 13.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageMeal: UIImageView!
    
    var array = [Date]()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
       return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.delegate = self
        imageMeal.image = UIImage(named: "meal")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let date = Date()
        array.append(date)
        print(array.count)
        print(array[array.count - 1])
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My happy meal time"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        //let date = array[indexPath.row]
        cell.textLabel?.text = "dateFormatter.string(from: date)"
        cell.detailTextLabel?.text = "sdadafdsfa"
        return cell
    }
}

