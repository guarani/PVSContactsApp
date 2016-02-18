//
//  PVSSummaryTableViewCell.swift
//  PVSContactsApp
//
//  Created by Paul Von Schrottky on 2/18/16.
//  Copyright © 2016 Paul Von Schrottky. All rights reserved.
//

import UIKit

class PVSSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
