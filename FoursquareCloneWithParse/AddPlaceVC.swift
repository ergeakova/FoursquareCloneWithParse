//
//  AddPlaceVC.swift
//  FoursquareCloneWithParse
//
//  Created by Erge Gevher Akova on 26.06.2022.
//

import UIKit

class AddPlaceVC: UIViewController {

    var utl = Utils()
    
    @IBOutlet weak var txtPlaceName: UITextField!
    @IBOutlet weak var txtPlaceType: UITextField!
    @IBOutlet weak var txtPlaceAtmosphere: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if utl.isEmptyString(value: txtPlaceName.text!) && utl.isEmptyString(value: txtPlaceType.text!) {
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        } else{
            self.present(utl.showBasicAlert(tit: "Error!" , msg: "Place Image, Place name and Place type cannot be empty!"), animated: true)
        }
    }
}
