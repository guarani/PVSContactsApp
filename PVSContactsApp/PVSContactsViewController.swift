//
//  PVSContactsViewController.swift
//  PVSContactsApp
//
//  Created by Paul Von Schrottky on 2/17/16.
//  Copyright © 2016 Paul Von Schrottky. All rights reserved.
//

import UIKit

class PVSContactsViewController: PVSBaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    var contactList = [[String: AnyObject]]()
    var filteredContactList = [[String: AnyObject]]()
    var selectedContact: PVSDictionary!
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contacts"
        
        let menuImage = UIImage(named: "ham")?.imageWithRenderingMode(.AlwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, style: .Plain, target: self, action: "menuButtonAction:")
        navigationItem.leftBarButtonItem?.tintColor = PVSConstants.Colors.Active
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        

        
        // Remove empty cells.
        tableView.tableFooterView = UIView()
        
        // Register the cell for this table view.
        tableView.registerNib(UINib(nibName: "PVSContactTableViewCell", bundle: nil), forCellReuseIdentifier: "PVSContactTableViewCellReuseID")

        PVSComm.retrieveContacts() { contacts in
            self.contactList = contacts
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: UISearchControllerDelegate
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        guard let query = searchController.searchBar.text where query.isEmpty == false else {
            filteredContactList = contactList
            tableView.reloadData()
            return
        }
        // Search ignoring diacritic differences.
        let predicate = NSPredicate(format: "(name contains[cd] %@) OR (companyDetails.name contains[cd] %@)", query, query)
        filteredContactList = contactList.filter { predicate.evaluateWithObject($0) }
        tableView.reloadData()
    }
    

    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func searchAction(sender: UIBarButtonItem) {
        
    }


    func menuButtonAction(sender: UIBarButtonItem) {
        let menuViewController = navigationController?.parentViewController as? PVSMenuViewController
        menuViewController?.toggleMenu()
    }


    
    
    // MARK: - Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
           return filteredContactList.count
        } else {
            return contactList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PVSContactTableViewCellReuseID") as! PVSContactTableViewCell
        let contact: PVSDictionary!
        if searchController.active {
            contact = filteredContactList[indexPath.row]
        } else {
            contact = contactList[indexPath.row]
        }
        
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
        if searchController.active {
            selectedContact = filteredContactList[indexPath.row]
        } else {
            selectedContact = contactList[indexPath.row]
        }
        
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
