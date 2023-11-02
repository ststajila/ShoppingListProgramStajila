//
//  ViewController.swift
//  ShoppingListProgramStajila
//
//  Created by STANISLAV STAJILA on 11/1/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var defaults = UserDefaults.standard
    var items: [String] = ["Milk", "Bread", "Eggs"]
    var alert = UIAlertController(title: "Error", message: "the item is already in your shoping list!", preferredStyle: .alert)
    var input = UIAlertController(title: "Invalid Input", message: "To add an item you must type its name", preferredStyle: .alert)
    
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var itemOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.array(forKey: "items") != nil {
            items = defaults.array(forKey: "items") as! [String]
        }
        mainTableView.delegate = self
        mainTableView.dataSource = self
        let okAction = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okAction)
        input.addAction(okAction)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "itemsCell")
        cell!.textLabel?.text = items[indexPath.row]
        return cell!
    }
    
    @IBAction func add(_ sender: Any) {
        
        if itemOutlet.text != "" {
            if isInArray(array: items, item: itemOutlet.text!) == false{
                items.append(itemOutlet.text!)
                mainTableView.reloadData()
                itemOutlet.text = ""
                defaults.set(items, forKey: "items")
                sortButton.backgroundColor = UIColor.lightGray
            }
            else{
                present(alert, animated: true, completion: nil)
            }
            
        } else{
            present(input, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            defaults.set(items, forKey: "items")
        }
    }
    

    func isInArray(array: [String], item: String) -> Bool{
        for i in array{
            if i.lowercased() == item.lowercased(){
                return true
            }
        }
        return false
    }
    
    
    @IBAction func sort(_ sender: Any) {
        sortButton.backgroundColor = UIColor.green
        items.sort(by: <)
        defaults.set(items, forKey: "items")
        mainTableView.reloadData()
    }
    
}

