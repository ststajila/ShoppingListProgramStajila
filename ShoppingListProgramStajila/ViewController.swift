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
    var items: [Items] = [Items(name: "Milk", checkStatus: false),Items(name: "Bread", checkStatus: false), Items(name: "Eggs", checkStatus: false)]
    var alert = UIAlertController(title: "Error", message: "the item is already in your shoping list!", preferredStyle: .alert)
    var input = UIAlertController(title: "Invalid Input", message: "To add an item you must type its name", preferredStyle: .alert)
    
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var itemOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.array(forKey: "items") != nil{
            let encoder = JSONEncoder()
              if let encoded = try? encoder.encode(items) {
                               defaults.set(encoded, forKey: "items")
                           }
        }
        
        if let itemsArray = defaults.data(forKey: "items") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([Items].self, from: itemsArray) {
                            items = decoded
                        }
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
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.nameOutlet.text = items[indexPath.row].name
        if items[indexPath.row].checkStatus{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else{
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        return cell
    }
    
    @IBAction func add(_ sender: Any) {
        
        if itemOutlet.text != "" {
            if isInArray(array: items, item: itemOutlet.text!) == false{
                items.append(Items(name: itemOutlet.text!, checkStatus: false))
                
             mainTableView.reloadData()
                
                
                itemOutlet.text = ""
            
                let encoder = JSONEncoder()
                  if let encoded = try? encoder.encode(items) {
                                   UserDefaults.standard.set(encoded, forKey: "items")
                               }
                
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
           
            let encoder = JSONEncoder()
              if let encoded = try? encoder.encode(items) {
                               defaults.set(encoded, forKey: "items")
                           }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if items[indexPath.row].checkStatus == false{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            items[indexPath.row].checkStatus = true
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                defaults.set(encoded, forKey: "items")
            }
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            
            items[indexPath.row].checkStatus = false
           
            let encoder = JSONEncoder()
              if let encoded = try? encoder.encode(items) {
                               defaults.set(encoded, forKey: "items")
                           }
        }
        
    }
    

    func isInArray(array: [Items], item: String) -> Bool{
        for i in array{
            if i.name.lowercased() == item.lowercased(){
                return true
            }
        }
        return false
    }
    
    
    @IBAction func sort(_ sender: Any) {
        sortButton.backgroundColor = UIColor.blue
        items.sort(by: { $0.name < $1.name } )
        
        let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(items) {
                           defaults.set(encoded, forKey: "items")
                       }
        
        mainTableView.reloadData()

    }
    
}

