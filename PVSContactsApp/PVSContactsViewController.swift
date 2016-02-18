//
//  PVSContactsViewController.swift
//  PVSContactsApp
//
//  Created by Paul Von Schrottky on 2/17/16.
//  Copyright © 2016 Paul Von Schrottky. All rights reserved.
//

import UIKit

class PVSContactsViewController: PVSBaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var contactList = [[String: AnyObject]]()
    var selectedContact: PVSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contacts"
        
        let menuImage = UIImage(named: "ham")?.imageWithRenderingMode(.AlwaysTemplate)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, style: .Plain, target: self, action: "menuButtonAction:")
        self.navigationItem.leftBarButtonItem?.tintColor = PVSConstants.Colors.Active
        
        // Remove empty cells.
        tableView.tableFooterView = UIView()
        
        // Register the cell for this table view.
        tableView.registerNib(UINib(nibName: "PVSContactTableViewCell", bundle: nil), forCellReuseIdentifier: "PVSContactTableViewCellReuseID")

        PVSComm.retrieveContacts() { contacts in
            self.contactList = contacts
            self.tableView.reloadData()
        }
        
    }
    

    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }


    func menuButtonAction(sender: UIBarButtonItem) {
        let menuViewController = navigationController?.parentViewController as? PVSMenuViewController
        menuViewController?.toggleMenu()
    }


    
    
    // MARK: - Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PVSContactTableViewCellReuseID") as! PVSContactTableViewCell
        let contact = contactList[indexPath.row]
        
        let photoURL = NSURL(string: contact["imageUrl"] as! String)!
        
        NSURLSession.sharedSession().dataTaskWithURL(photoURL, completionHandler: { data, response, error in
            if data != nil {
                let image = UIImage(data: data!)
                dispatch_async(dispatch_get_main_queue(), {
                    if let theCell = tableView.cellForRowAtIndexPath(indexPath) as? PVSContactTableViewCell {
                        theCell.photoImageView.image = image
                    }
                })
            }
        }).resume()
        
        
        
        
        cell.nameLabel?.text = contact["name"] as? String
        let companyDetails = contact["companyDetails"] as! PVSDictionary
        cell.companyNameLabel?.text = companyDetails["name"] as? String
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedContact = contactList[indexPath.row]
        performSegueWithIdentifier("PVSContactsToContactDetailsSegue", sender: self)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PVSContactsToContactDetailsSegue" {
            let contactDetailsViewController = segue.destinationViewController as! PVSContactDetailViewController
            contactDetailsViewController.selectedContact = self.selectedContact
            
        }
    }

}
