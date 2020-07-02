//
//  ViewController.swift
//  UKaren
//
//  Created by sowah on 7/1/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var data = [Word]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
    }
    
    func parseJson() {
        guard let urlString = Bundle.main.url(forResource: "DataFile.json", withExtension: nil) else {
            fatalError("Failed to locate in bundle.")
        }
        
        if let data = try? Data(contentsOf: urlString) {
            // we're OK to parse!
            
            if let json = try? JSONDecoder().decode([Word].self, from: data) {
                json.forEach { (word) in
                    self.data.append(word)
                    
                }
            }
            tableView.reloadData()
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
    
}


