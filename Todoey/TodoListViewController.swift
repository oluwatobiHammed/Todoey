//
//  ViewController.swift
//  Todoey
//
//  Created by user on 17/05/2019.
//  Copyright © 2019 Oladipupo Oluwatbi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var defaults = UserDefaults.standard
    
    var arrayOfItem = ["Find Faith", "Buy Eggs", "Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            
            arrayOfItem = items
        }
    }
    
    //Mark Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = arrayOfItem[indexPath.row]
        
        return cell
    }
    
    
     //Mark Tableview Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(arrayOfItem[indexPath.row])
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What Will happen once the user click the add button on our UIAlert
            //print(textField.text!)
            self.arrayOfItem.append(textField.text!)
            
            self.defaults.set(self.arrayOfItem, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
   
 
}

