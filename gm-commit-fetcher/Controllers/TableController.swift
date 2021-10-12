//
//  TableController.swift
//  gm-commit-fetcher
//
//  Created by Cole Charles on 10/12/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var dataSource: [Commits] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        CommitManager.shared.getCommits(completion: {
            array in print(array)
            self.dataSource = array
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if self.dataSource.count > 0 {

            cell.textLabel?.text = self.dataSource[indexPath.row].author
            return cell
        }
        return cell
    }
    
    
    
}
