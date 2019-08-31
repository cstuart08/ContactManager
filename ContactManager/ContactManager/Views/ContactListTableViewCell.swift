//
//  ContactListTableViewCell.swift
//  ContactManager
//
//  Created by Apps on 8/30/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    var contact: Contact? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    func updateViews() {
        guard let contact = contact else { return }
        nameLabel.text = contact.name
        phoneLabel.text = contact.phone ?? "No phone number set."
        emailLabel.text = contact.email ?? "No email address set."
    }
}
