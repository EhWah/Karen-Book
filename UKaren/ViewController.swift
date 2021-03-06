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
    var filterData = [Word]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        searchControllerSetUp()
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
    
    func searchControllerSetUp() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "type your word..."
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filterData = data.filter({ (word) -> Bool in
            return word.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadSections([0], with: UITableView.RowAnimation.automatic)
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filterData.count
        } else {
            return data.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 19)]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, .font: UIFont.italicSystemFont(ofSize: 15) ]
        
        if isFiltering() {
            let firstString = NSMutableAttributedString(string: filterData[indexPath.row].name, attributes: firstAttributes)
            let secondString = NSAttributedString(string: filterData[indexPath.row].detail, attributes: secondAttributes)
            firstString.append(secondString)
            
            cell.textLabel?.attributedText = firstString
            cell.detailTextLabel?.text = filterData[indexPath.row].andDescription
        } else {
            let firstString = NSMutableAttributedString(string: data[indexPath.row].name, attributes: firstAttributes)
            let secondString = NSAttributedString(string: data[indexPath.row].detail, attributes: secondAttributes)
            firstString.append(secondString)
            
            cell.textLabel?.attributedText = firstString
            cell.detailTextLabel?.text = data[indexPath.row].andDescription
        }
        return cell
    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
