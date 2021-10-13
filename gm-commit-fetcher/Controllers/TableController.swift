//
//  TableController.swift
//  gm-commit-fetcher
//
//  Created by Cole Charles on 10/12/21.
//

import UIKit

// custom table cell class
class commitTableViewCell: UITableViewCell {
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var author: UILabel!
}

class TableViewController: UITableViewController {
    
    var dataSource: [Commits] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refetchData), for: .valueChanged)
    }
    
    @objc private func refetchData() {
        CommitManager.shared.getCommits(completion: {
            array in
            self.dataSource = CommitManager.shared.commits
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        })
    }
    
    func fetchData() {
        CommitManager.shared.getCommits(completion: {
            _ in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.dataSource = CommitManager.shared.commits
                self.tableView.reloadData()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if self.dataSource.count > 0 {
            let cells = tableView.dequeueReusableCell(withIdentifier: "commitCell", for: indexPath) as! commitTableViewCell
            
            cells.author?.text = self.dataSource[indexPath.row].author
            cells.message?.text = self.dataSource[indexPath.row].message
            cells.id?.text = self.dataSource[indexPath.row].hash
            return cells
        }
        return cell
    }
}
