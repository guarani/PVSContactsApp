//
//  PVSSectionLabel.swift
//  PVSContactsApp
//
//  Created by Paul Von Schrottky on 2/18/16.
//  Copyright © 2016 Paul Von Schrottky. All rights reserved.
//

import UIKit

class PVSSectionLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 10, 0, 0)))
    }

}
