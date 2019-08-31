//
//  Contact.swift
//  ContactManager
//
//  Created by Apps on 8/30/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import Foundation
import CloudKit

struct ContactConstants {
    static let recordTypeKey = "Contact"
    fileprivate static let nameKey = "name"
    fileprivate static let phoneKey = "phone"
    fileprivate static let emailKey = "email"
}

class Contact {
    var name: String
    var phone: String?
    var email: String?
    let ckRecordID: CKRecord.ID
    
    init(name: String, phone: String?, email: String?, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.phone = phone
        self.email = email
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(record: CKRecord) {
        guard let name = record[ContactConstants.nameKey] as? String,
            let phone = record[ContactConstants.phoneKey] as? String,
            let email = record[ContactConstants.emailKey] as? String else { return nil }
        
        self.init(name: name, phone: phone, email: email, ckRecordID: record.recordID)
        
    }
}

extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ContactConstants.recordTypeKey, recordID: contact.ckRecordID)
        self.setValue(contact.name, forKey: ContactConstants.nameKey)
        self.setValue(contact.phone, forKey: ContactConstants.phoneKey)
        self.setValue(contact.email, forKey: ContactConstants.emailKey)
    }
}
