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
  
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (dataFilePath)
        
        loadItems()
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
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
           self.saveData()
        }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new Item"
                textField = alertTextField
        }
     
        
        alert.addAction(action)
            
        present(alert, animated: true, completion: nil)
            
        
    }
    
    func saveData() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }

    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([item].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
    
}

