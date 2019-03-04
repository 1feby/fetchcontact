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
    var fetcontacts : [CONTACTS] = []
    var contactstr : [String] = []
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
   var filterdItemsArray = [String]()
    func filterContentForSearchText(searchText: String) {
        filterdItemsArray = contactstr.filter { item in
            
            return item.lowercased().contains(searchText.lowercased())
        }
    }
    let fileURL = "/Users/phoebeezzat/Desktop/test.txt"
    var arrayOfStrings : [String] = []
    @IBAction func fetchcontact(_ sender: UIButton) {
        do {
            // Read file content
            let contents = try NSString(contentsOfFile: fileURL, encoding: String.Encoding.utf8.rawValue)
           let texttoread = contents as String
            arrayOfStrings = texttoread.components(separatedBy: " ");
            //print("bb \(arrayOfStrings.count)")
            filterContentForSearchText(searchText: arrayOfStrings[1])
            for p in 0...filterdItemsArray.count{
                print(filterdItemsArray.count)
            }
            
            print(" the text is \(contents)")
        }
        catch  {
            print("An error took place: \(error)")
        }
        
        /*var filtered = fetcontacts.filter {$0.firstName == text}
        print(filtered.count)
        for p in 0...filtered.count{
            print(filtered[p].number)
        }*/
        
        /*   if let foo = fetcontacts.enumerated().first(where: {$0.element.firstName == "John"}) {
            // do something with foo.offset and foo.element
            print(fetcontacts[foo.offset].number)
        } else {
            // item could not be found
            print("couldn't found")
        }*/
        
    }
    func fetchcontacts() -> [CONTACTS]{
        
        let ContactStore = CNContactStore()
        let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
        let fetchreq = CNContactFetchRequest.init(keysToFetch: keys as! [CNKeyDescriptor] )
        do{
            try ContactStore.enumerateContacts(with: fetchreq) { (contact, end) in
               let datacontant = CONTACTS(NAME: "\(contact.givenName) \(contact.familyName)", phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? "")
                self.fetcontacts.append(datacontant)
                self.contactstr.append(datacontant.fullname)
                print(contact.givenName)
                print(contact.phoneNumbers.first?.value.stringValue ?? "")
            }}
        catch{
            print("failed to fetch")
        }
        return fetcontacts
    }
}
