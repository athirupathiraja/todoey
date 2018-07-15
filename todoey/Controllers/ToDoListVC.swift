//
//  ViewController.swift
//  todoey
//
//  Created by Athiru Pathiraja on 7/15/18.
//  Copyright © 2018 litshiz.org. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var itemArray = [item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = item()
        newItem.title = "go shopping"
        itemArray.append(newItem)
        
        let newItem2 = item()
        newItem2.title = "go eat dinner"
        itemArray.append(newItem2)
        
        let newItem3 = item()
        newItem3.title = "go eat lunch"
        itemArray.append(newItem3)
        
        
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [item] {
            itemArray = items
        }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemList", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArry [indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
      
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
           self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new Item"
                textField = alertTextField
        }
     
        
        alert.addAction(action)
            
        present(alert, animated: true, completion: nil)
            
        
    }
    


}

