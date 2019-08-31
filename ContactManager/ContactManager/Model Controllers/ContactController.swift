//
//  ContactController.swift
//  ContactManager
//
//  Created by Apps on 8/30/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    static let shared = ContactController()
    
    var contacts: [Contact] = []
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: CRUD
    // Create
    func createContact(name: String, phone: String?, email: String?, completion: @escaping (Bool) -> Void) {
        let newContact = Contact(name: name, phone: phone, email: email)
        
        let newRecord = CKRecord(contact: newContact)
        
        publicDB.save(newRecord) { (record, error) in
            if let error = error {
                print("Error saving a new contact: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let record = record,
                let contact = Contact(record: record) else { completion(false); return }
            self.contacts.append(contact)
            completion(true)
        }
    }
    
    func fetchAllContacts(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: ContactConstants.recordTypeKey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching all contacts: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else { completion(false); return }
            
            let contacts = records.compactMap({ Contact(record: $0) })
            self.contacts = contacts
            completion(true)
        }
    }
    
    func updateContact(contact: Contact, completion: @escaping (Bool) -> Void) {
        
        let updateOp = CKModifyRecordsOperation(recordsToSave: [CKRecord(contact: contact)], recordIDsToDelete: nil)
        updateOp.savePolicy = .changedKeys
        updateOp.queuePriority = .veryHigh
        updateOp.qualityOfService = .userInteractive
        updateOp.completionBlock = {
            completion(true)
            print("Contact was successfully updated")
        }
        
        publicDB.add(updateOp)
    }
}
