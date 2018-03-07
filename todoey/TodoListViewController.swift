//
//  ViewController.swift
//  todoey
//
//  Created by Nguyen Duc Tai on 2/23/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    var itemArray = [item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataPath!)
        decodeData()
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
        encodeData()
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
            self.encodeData()
            self.tableView.reloadData()
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    func encodeData()
    {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataPath!)
        }
        catch
        {
            print("error encode")
        }
    }
    func decodeData()
    {
        do {
            let data = try Data(contentsOf: dataPath!)
            let decoder = PropertyListDecoder()
            itemArray = try decoder.decode([item].self, from: data)
        }
        catch
        {
            print("decode data error")
        }
    }
    
}

