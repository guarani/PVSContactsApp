//
//  PVSContactDetailViewController.swift
//  PVSContactsApp
//
//  Created by Paul Von Schrottky on 2/17/16.
//  Copyright © 2016 Paul Von Schrottky. All rights reserved.
//

import UIKit

class PVSContactDetailViewController: PVSBaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var photoImageView: UIImageView!
    var selectedContact: PVSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedContact["name"] as! String
        
        // Round the user's photo.
        let photoURL = NSURL(string: selectedContact["imageUrl"] as! String)!
        self.photoImageView.image = UIImage(data: NSData(contentsOfURL: photoURL)!)
        photoImageView.layer.cornerRadius = 50
        photoImageView.layer.masksToBounds = true
        
        // Dynamic cell heights.
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Register the cell for this table view.
        tableView.registerNib(UINib(nibName: "PVSSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "PVSSummaryTableViewCellReuseID")
        tableView.registerNib(UINib(nibName: "PVSCommunicationTableViewCell", bundle: nil), forCellReuseIdentifier: "PVSCommunicationTableViewCellReuseID")
        
        // Remove empty cells.
        tableView.tableFooterView = UIView()
    }


    // MARK: - Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = PVSSectionLabel()
        label.textColor = PVSConstants.Colors.LightText
        label.backgroundColor = PVSConstants.Colors.Foreground
        switch section {
        case 0:
            label.text = "Summary"
        case 1:
            label.text = "Contact"
        case 2:
            label.text = "Address"
        case 3:
            label.text = "Work Address"
        case 4:
            label.text = "Home Page"
        default:
            break
        }
        return label
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("PVSSummaryTableViewCellReuseID") as! PVSSummaryTableViewCell
            cell.textLabel?.textColor = PVSConstants.Colors.Text
            cell.nameLabel.text = selectedContact["name"] as? String
            let companyDetails = selectedContact["companyDetails"] as! PVSDictionary
            let position = selectedContact["position"] as! String
            let companyName = companyDetails["name"] as! String
            cell.positionLabel.text = position + " at " + companyName
            cell.selectionStyle = .None
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("PVSCommunicationTableViewCellReuseID") as! PVSCommunicationTableViewCell
            cell.textLabel?.textColor = PVSConstants.Colors.Text
            let phones = selectedContact["phone"] as! PVSArray
            cell.line1Label.text = phones[0]["number"] as? String
            cell.line2Label.text = phones[1]["number"] as? String
            let emails = selectedContact["emails"] as! PVSArray
            cell.line3Label.text = emails[0]["email"] as? String
            cell.line4Label.text = emails[1]["email"] as? String
            cell.selectionStyle = .None
            return cell
        case 2:
            let cell = UITableViewCell()
            cell.textLabel?.textColor = PVSConstants.Colors.Text
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .ByWordWrapping
            let address = (selectedContact["address"] as! PVSArray).first!
            cell.textLabel?.text =
                (address["address1"] as! String) + "\n" +
                (address["address2"] as! String) + "\n" +
                (address["address3"] as! String) + "\n" +
                String(address["zipcode"] as! Int) + "\n" +
                (address["country"] as! String) + "\n" +
                (address["city"] as! String) + "\n" +
                (address["state"] as! String)
            cell.selectionStyle = .None
            return cell
        case 3:
            let cell = UITableViewCell()
            cell.textLabel?.textColor = PVSConstants.Colors.Text
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .ByWordWrapping
            let companyDetails = selectedContact["companyDetails"] as! PVSDictionary
            cell.textLabel?.text =
                (companyDetails["name"] as! String) + "\n" +
                (companyDetails["location"] as! String)
            cell.selectionStyle = .None
            return cell
        case 4:
            let cell = UITableViewCell()
            cell.textLabel?.textColor = PVSConstants.Colors.Text
            cell.textLabel?.text = selectedContact["homePage"] as? String
            cell.selectionStyle = .None
            return cell
        default:
            return UITableViewCell()
        }
    }
}
