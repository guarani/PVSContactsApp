//
//  PVSLoginViewController.swift
//  PVSContactsApp
//
//  Created by Paul Von Schrottky on 2/17/16.
//  Copyright © 2016 Paul Von Schrottky. All rights reserved.
//

import UIKit

class PVSLoginViewController: PVSBaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        let emailLabel = UILabel(frame: CGRectMake(0, 0, 50, 26))
        emailLabel.textColor = PVSConstants.Colors.Text
        emailLabel.text = "Email"
        emailTextField.leftView = emailLabel
        emailTextField.leftViewMode = .Always
        
        let passLabel = UILabel(frame: CGRectMake(0, 0, 80, 26))
        passLabel.textColor = PVSConstants.Colors.Text
        passLabel.text = "Password"
        passTextField.leftView = passLabel
        passTextField.leftViewMode = .Always
        
        loginButton.backgroundColor = PVSConstants.Colors.Active
        loginButton.setTitleColor(PVSConstants.Colors.LightText, forState: .Normal)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonAction(sender: AnyObject) {
        
        if emailTextField.text?.isEmpty == true {
            Utils.showMessage("Please enter your email", inViewController: self)
            return
        } else if passTextField.text?.isEmpty == true {
            Utils.showMessage("Please enter your password", inViewController: self)
            return
        } else {
            self.passTextField.text = nil
            self.view.endEditing(true)
            self.performSegueWithIdentifier("PVSLoginToContactsSegue", sender: self)
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
