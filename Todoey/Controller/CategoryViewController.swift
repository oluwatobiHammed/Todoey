//
//  CategoryViewController.swift
//  Todoey
//
//  Created by user on 20/05/2019.
//  Copyright © 2019 Oladipupo Oluwatbi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
      let realm = try! Realm()
    
    var Categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadCategories()
    }
    // Mark TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Categories?.count ?? 1
    }
    // Mark TableView Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = Categories?[indexPath.row]
        
        cell.textLabel?.text = item?.name ?? "No Category Add yet"
        
//        cell.accessoryType = item.marked ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        performSegue(withIdentifier: "goToItems", sender: self)
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selctedCategory = Categories?[indexPath.row]
        }
    }
    
    // Mark Data Manipulation methods  loadItems
    func loadCategories (){
        
        Categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    


    @IBAction func addButttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What Will happen once the user click the add button on our UIAlert
            //print(textField.text!)
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    // Mark Data Manipulation methods  saveItems
    func save(category: Category){
        
        do
        {
            try realm.write {
                realm.add(category)
            }
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
}
