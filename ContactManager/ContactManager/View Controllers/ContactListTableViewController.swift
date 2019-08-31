//
//  ContactListTableViewController.swift
//  ContactManager
//
//  Created by Apps on 8/30/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }

    func loadData() {
        ContactController.shared.fetchAllContacts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? ContactListTableViewCell else { return UITableViewCell() }
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.contact = contact

        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destVC = segue.destination as? ContactDetailViewController else { return }
            let contact = ContactController.shared.contacts[indexPath.row]
            destVC.contact = contact
        }
    }
}
