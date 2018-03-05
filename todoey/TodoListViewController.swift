//
//  ViewController.swift
//  todoey
//
//  Created by Nguyen Duc Tai on 2/23/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //var item:Array = ["mua trung","mua thit ga","mua thit bo"]
    //var defaults = UserDefaults.standard
    var itemArray = [item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //item = defaults.array(forKey: "hue") as! Array<String>
        var newI = item()
        newI.title = "Mua trung"
        itemArray.append(newI)
        var newI2 = item()
        newI2.title = "Mua thit"
        itemArray.append(newI2)
        var newI3 = item()
        newI3.title = "Mua nac"
        itemArray.append(newI3)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    //Mark: tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
//    Mark: addPressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController.init(title: "Add", message: nil, preferredStyle: .alert)
        var textF = UITextField()
        alert.addTextField { (txt) in
            txt.placeholder = "Fill in the blank"
            textF = txt
        }
        var new = item()
        let alertAction = UIAlertAction.init(title: "Add", style: .default) { (action) in
            new.title = textF.text!
            self.itemArray.append(new)
            //self.defaults.set(self.item, forKey: "hue")
            self.tableView.reloadData()
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}

