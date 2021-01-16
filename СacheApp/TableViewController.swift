//
//  TableViewController.swift
//  СacheApp
//
//  Created by Yevhen Shevchenko on 16.01.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var employees = [Result]()
    
    let customeRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(sender:)), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Employees"
        
        tableView.rowHeight = 100
        tableView.refreshControl = customeRefreshControl
        
        NetworkManager.shared.fetchData {
            self.employees = $0.results!
            self.tableView.reloadData()
        }
    }
    
    @objc private func refreshControlAction(sender: UIRefreshControl) {
        NetworkManager.shared.fetchData {
            self.employees = $0.results!
            sender.endRefreshing()
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomeTableViewCell
     
        let employee = employees[indexPath.row]

        cell.configure(with: employee)
        
        return cell
    }
}
