//
//  ViewController.swift
//  fetchcontact
//
//  Created by phoebe on 2/28/19.
//  Copyright © 2019 phoebe. All rights reserved.
//

import UIKit
import Contacts
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let arraycontacts = fetchcontacts()
        print(arraycontacts.count)
        }
    /*func saveContactToDocument(contact : [CNContact]){
        let documentpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let fileUrl = URL.init(fileURLWithPath: documentpath.appending("/MYcontacts.vcf"))
        let data : NSData?
        do{
            try data = CNContactVCardSerialization.data(with: contact) as NSData
            do{
                try data?.write(to: fileUrl, options: [.atomicWrite])
                print(fileUrl.absoluteString)
            }catch{
                print("failed to write")
            }
        }catch{
            print("failed")
        }
    }*/
    
    @IBAction func fetchcontact(_ sender: UIButton) {
    }
    func fetchcontacts() -> [CNContact]{
        var contacts : [CNContact] = []
        let ContactStore = CNContactStore()
        let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
        let fetchreq = CNContactFetchRequest.init(keysToFetch: keys as [CNKeyDescriptor] )
        do{
        try ContactStore.enumerateContacts(with: fetchreq) { (contact, end) in
            contacts.append(contact)
            print(contact.givenName)
            print(contact.phoneNumbers.first?.value.stringValue ?? "")
            }}
        catch{
            print("failed to fetch")
        }
        return contacts
    }
}

