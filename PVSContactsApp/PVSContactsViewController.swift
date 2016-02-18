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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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


    


    
    
    // MARK: - Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PVSContactTableViewCellReuseID") as! PVSContactTableViewCell
        let contact = contactList[indexPath.row]
        
        let photoURL = NSURL(string: contact["imageUrl"] as! String)!
        cell.photoImageView.image = UIImage(data: NSData(contentsOfURL: photoURL)!)
        cell.nameLabel?.text = contact["name"] as? String
        let companyDetails = contact["companyDetails"] as! PVSDictionary
        cell.companyNameLabel?.text = companyDetails["name"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    // MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
