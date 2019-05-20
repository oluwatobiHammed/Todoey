//
//  ViewController.swift
//  Todoey
//
//  Created by user on 17/05/2019.
//  Copyright © 2019 Oladipupo Oluwatbi. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    
    
    var arrayOfItem = [Item]()
    
    var selctedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
    
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
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.marked = false
            newItem.parentcategory = self.selctedCategory
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
       
        do
        {
           
            try context.save()
            
        }catch{
            print(error)
        }
        
        
        tableView.reloadData()
    
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),  with predicate: NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "parentcategory.name MATCHES %@", selctedCategory!.name!)
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionalPredicate])
        }else {
            request.predicate = categoryPredicate
        }
        
        do{
            
           arrayOfItem = try context.fetch(request)

        }
        catch{
            print(error)
        }
        
        tableView.reloadData()
    }
    
   
 
}

// MARK: - Search bar Methods
extension TodoListViewController:  UISearchBarDelegate {
    
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchBar.delegate = self;
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
         request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        
        do{

            arrayOfItem = try context.fetch(request)

        }
        catch{
            print(error)
        }

        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

