//
//  ViewController.swift
//  fetchcontact
//
//  Created by phoebe on 3/5/19.
//  Copyright © 2019 phoebe. All rights reserved.
//

import UIKit
import Contacts
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
   
     var filterdItemsArray = [CONTACTS]()
    var fetcontacts : [CONTACTS] = []
    var contactdic : [String] = []
    
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
   
    func filterContentForSearchText(searchText: String)  {
        filterdItemsArray = fetcontacts.filter { item in
            return item.fullname.lowercased().contains(searchText.lowercased())
        }
    }
    let fileURL = "/Users/phoebeezzat/Desktop/test.txt"
    var arrayOfStrings : [String] = []

 
    func update(){
        do{
        let contents = try NSString(contentsOfFile: fileURL, encoding: String.Encoding.utf8.rawValue)
        let texttoread = contents as String
        arrayOfStrings = texttoread.components(separatedBy: " ");
        //print("bb \(arrayOfStrings.count)")
        filterContentForSearchText(searchText: arrayOfStrings[1])
        for p in 0...filterdItemsArray.count{
            print(filterdItemsArray.count)
        }
        if filterdItemsArray.count == 2 {
            print(filterdItemsArray[0].fullname)
            print(filterdItemsArray[0].number)
        }
        
        print(" the text is \(contents)")
    }catch  {
    print("An error took place: \(error)")
    }    }
    func fetchcontacts() -> [CONTACTS]{
        
        let ContactStore = CNContactStore()
        let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
        let fetchreq = CNContactFetchRequest.init(keysToFetch: keys as [CNKeyDescriptor] )
        do{
            try ContactStore.enumerateContacts(with: fetchreq) { (contact, end) in
                let datacontant = CONTACTS(NAME: "\(contact.givenName) \(contact.familyName)", phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? "")
                self.fetcontacts.append(datacontant)
                //    let dict = [ datacontant.fullname: datacontant.number]
                //    self.contactdic.append(dict)
                print(contact.givenName)
                print(contact.phoneNumbers.first?.value.stringValue ?? "")
            }}
        catch{
            print("failed to fetch")
        }
        return fetcontacts
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    update()
        return filterdItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = filterdItemsArray[indexPath.row].fullname
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filterdItemsArray[indexPath.row].number)
    }
}

