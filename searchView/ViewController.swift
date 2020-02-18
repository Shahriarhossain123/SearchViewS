//
//  ViewController.swift
//  searchView
//
//  Created by apple on 2/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var searchtable: UITableView!
    @IBOutlet weak var searchText: UISearchBar!
    
    var item = ["Apple", "Dell", "ASUS", "Lenovo","MSI"]
    var searching = false
    var mysearch = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        searchEdit()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return mysearch.count
        } else{
            return item.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if searching{
            cell?.textLabel?.text = mysearch[indexPath.row]
        } else{
            cell?.textLabel?.text = item[indexPath.row]
        }
        
        return cell!
    }
    
    func searchEdit() {
        searchText.searchTextField.layer.borderWidth = 1
        searchText.searchTextField.layer.borderColor = UIColor.black.cgColor
        searchText.searchTextField.layer.cornerRadius = 10
        
        searchText.layer.backgroundColor = UIColor.black.cgColor
        searchText.searchTextField.layer.backgroundColor = UIColor.white.cgColor
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }

}

//MARK: Serach Bar
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        mysearch = item.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        
        searching = true
        searchtable.reloadData()
    }
    
    //Search Cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchtable.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
}


