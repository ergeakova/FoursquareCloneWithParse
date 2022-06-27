//
//  AddPlaceVC.swift
//  FoursquareCloneWithParse
//
//  Created by Erge Gevher Akova on 26.06.2022.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var utl = Utils()
    
    @IBOutlet weak var txtPlaceName: UITextField!
    @IBOutlet weak var txtPlaceType: UITextField!
    @IBOutlet weak var txtPlaceAtmosphere: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeImageView.isUserInteractionEnabled = true
        let gestureRecongnizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecongnizer)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if utl.isEmptyString(value: txtPlaceName.text!) && utl.isEmptyString(value: txtPlaceType.text!) {
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        } else{
            self.present(utl.showBasicAlert(tit: "Error!" , msg: "Place Image, Place name and Place type cannot be empty!"), animated: true)
        }
    }
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}
