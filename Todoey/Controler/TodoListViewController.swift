//
//  ViewController.swift
//  Todoey
//
//  Created by user on 17/05/2019.
//  Copyright © 2019 Oladipupo Oluwatbi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    
    var arrayOfItem = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadItem()
    
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
        
        saveItems()
        
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
            
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems (){
       
        
        let encoder = PropertyListEncoder()
        do
        {
            let data =   try encoder.encode(arrayOfItem)
            
            try data.write(to: self.dataFilePath!)
            
        }catch{
            print(error)
        }
        
        
        self.tableView.reloadData()
    
    }
    
    func loadItem(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                arrayOfItem = try decoder.decode([Item].self, from: data)
            }
            catch{
                print(error)
            }
        }
    }
 
}


