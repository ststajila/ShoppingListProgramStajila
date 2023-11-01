//
//  ViewController.swift
//  ShoppingListProgramStajila
//
//  Created by STANISLAV STAJILA on 11/1/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    var items: [String] = ["Milk", "Bread", "Eggs"]
    
    @IBOutlet weak var itemOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
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
            items.append(itemOutlet.text!)
            mainTableView.reloadData()
            itemOutlet.text = ""
        } else{
            
        }
        
    }
    

}

