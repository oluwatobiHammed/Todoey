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
    
    var arrayOfItem = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Find Faith"
        arrayOfItem.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy egg"
        arrayOfItem.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        arrayOfItem.append(newItem3)
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            
           arrayOfItem = items
        }
    
    }
    //Mark Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = arrayOfItem[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.marked ? .checkmark : .none
        
        return cell
    }
    
    
     //Mark Tableview Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(arrayOfItem[indexPath.row])
       arrayOfItem[indexPath.row].marked = !arrayOfItem[indexPath.row].marked
        
       tableView.reloadData()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What Will happen once the user click the add button on our UIAlert
            //print(textField.text!)
            
            let newItem = Item()
            newItem.title = textField.text!
            self.arrayOfItem.append(newItem)
            
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


