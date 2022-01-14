//
//  ViewController.swift
//  CoreDataApp6
//
//  Created by Eugene on 13.01.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let coreDataStack = CoreDataStack()
    lazy var context = coreDataStack.persistentContainer.viewContext
    var array = [Date]()
    var person: Person!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageMeal: UIImageView!
    
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
       return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageMeal.image = UIImage(named: "meal")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let personName = "Max"
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", argumentArray: [personName])
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty{
                person = Person(context: context)
                person.name = personName
                try context.save()
            }else{
                person = results.first
            }
        } catch let error as NSError{
            print(error.userInfo)
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My happy meal time"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let meals = person.meals else {return 1}
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        guard let meal = person.meals?[indexPath.row] as? Meal, let mealDate = meal.date else
        {
            return cell
        }
        
        cell.textLabel?.text = dateFormatter.string(from: mealDate)
        return cell
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let meal = Meal(context: context)
        meal.date = Date()
        
        //cоздаем копируемую копию, так как то что приходит изменять нельзя! почему хз?!!!
        let meals = person.meals?.mutableCopy() as? NSMutableOrderedSet
        meals?.add(meal)
        //менять приходящий сет нельзя но заменить его можно
        person.meals = meals
        
        do {
            try context.save()
        } catch let error as NSError{
            print("Error: \(error), userInfo: \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //делает таблицу редактируемой
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let mealToDelete = person.meals?[indexPath.row] as? Meal, editingStyle == .delete else {return}
        context.delete(mealToDelete)
        
        do {
            try context.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError{
            print("Error: \(error), description: \(error.userInfo)")
        }
    }
    
}


