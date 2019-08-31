//
//  ContactDetailViewController.swift
//  ContactManager
//
//  Created by Apps on 8/30/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var contact: Contact? {
        didSet {
            loadViewIfNeeded()
            guard let contact = contact else { return }
            nameTextField.text = contact.name
            phoneTextField.text = contact.phone
            emailTextField.text = contact.email
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if nameTextField.text != "" {
            guard let name = nameTextField.text else { return }
            if let contact = contact {
                contact.name = name
                contact.phone = phoneTextField.text
                contact.email = emailTextField.text
                ContactController.shared.updateContact(contact: contact) { (success) in
                    if success {
                        DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        }
                        }
                    }
            } else {
                ContactController.shared.createContact(name: name, phone: phoneTextField.text, email: emailTextField.text) { (success) in
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
