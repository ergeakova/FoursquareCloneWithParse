//
//  ViewController.swift
//  FoursquareCloneWithParse
//
//  Created by Erge Gevher Akova on 26.06.2022.
//

import UIKit
import Parse

class SingUpVC: UIViewController {

    var utl = Utils()
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSingIn(_ sender: Any) {
        if utl.isEmptyString(value: txtUsername.text!) && utl.isEmptyString(value: txtPassword.text!) {
            PFUser.logInWithUsername(inBackground: txtUsername.text!, password: txtPassword.text!) { (user, error) in
                if error != nil {
                    self.present( self.utl.showBasicAlert(tit: "Error", msg: error?.localizedDescription ?? "Error"), animated: true)
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }
        else{
            self.present( self.utl.showBasicAlert(tit: "Error", msg: "Cannot be empty Username and Password!"), animated: true)
        }
    }
    
    @IBAction func btnSingUp(_ sender: Any) {
        if utl.isEmptyString(value: txtUsername.text!) && utl.isEmptyString(value: txtPassword.text!) {
            let user = PFUser()
            user.username = txtUsername.text!
            user.password = txtPassword.text!
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.present(self.utl.showBasicAlert(tit: "Error!", msg: error?.localizedDescription ?? "Error!!"), animated: true)
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }
        else{
            self.present( self.utl.showBasicAlert(tit: "Error", msg: "Cannot be empty Username and Password!"), animated: true)
        }
    }
    
}

