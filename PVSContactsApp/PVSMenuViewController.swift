//
//  PVSMenuViewController.swift
//  PVSContactsApp
//
//  Created by Paul Von Schrottky on 2/17/16.
//  Copyright © 2016 Paul Von Schrottky. All rights reserved.
//

import UIKit

enum PVSMenuState {
    case Closed
    case Opened
}

class PVSMenuViewController: UIViewController {
    
    var menuState: PVSMenuState = .Closed
    var panGestureRecognizer: UIPanGestureRecognizer?
    let menuGap: CGFloat = 60
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a shadow top and bottom.
        containerView.layer.shadowColor = UIColor.blackColor().CGColor
        containerView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 4.0
        let shadowRect = CGRectInset(containerView.bounds, 0, 10);  // inset top/bottom
        containerView.layer.shadowPath = UIBezierPath(rect: shadowRect).CGPath
        
        // Remove empty cells.
        tableView.tableFooterView = UIView()
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.containerView.addGestureRecognizer(self.panGestureRecognizer!)
        self.panGestureRecognizer!.enabled = true
    }
    
    func toggleMenu() {
        if menuState == .Closed {
            openMenu()
            menuState = .Opened
        } else {
            closeMenu()
            menuState = .Closed
        }
    }
    
    func openMenu() {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.containerView.frame.origin.x = self.view.bounds.size.width - self.menuGap
            self.containerView.alpha = 0.5
        }, completion: { _ in
            self.menuState = .Opened
        })
    }
    
    func closeMenu() {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.containerView.frame.origin.x = 0
            self.containerView.alpha = 1
        }, completion: { _ in

            self.menuState = .Closed
        })
    }
    
    // #MARK: - UIGestureRecognizerDelegate
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        let width = self.view.bounds.size.width
        
        switch(recognizer.state) {
            
        case .Changed:
            
            // translationInView gives the offset since the gesture started, or since setTranslation is last called.
            // Here we only allow the content to slide if it doesn't go too far left or right.
            let newPosition = recognizer.view!.center.x + recognizer.translationInView(self.view).x
            let isNotTooFarLeft = newPosition >= (width / 2)
            let isNotTooFarRight = newPosition <= width + (width / 2) - menuGap
            if isNotTooFarLeft && isNotTooFarRight {
                recognizer.view!.center.x = newPosition
            }
            
            // This resets the value of translationInView to zero.
            recognizer.setTranslation(CGPointZero, inView: self.view)
        case .Ended:
            
            // Animate the side panel open or closed based on whether the view has moved more or less than halfway
            // accross the screen.
            let hasMovedGreaterThanHalfway = recognizer.view!.center.x > width
            if hasMovedGreaterThanHalfway {
                openMenu()
            } else {
                closeMenu()
            }
            
        default:
            break
        }
    }
    
    // #MARK: - Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Log Out"
            cell.textLabel?.textColor = PVSConstants.Colors.Text
        default:
            break
        }

        return cell
    }
    
    // #MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.popViewControllerAnimated(true)
        default:
            break
        }
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
