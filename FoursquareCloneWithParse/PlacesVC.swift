//
//  PlacesVC.swift
//  FoursquareCloneWithParse
//
//  Created by Erge Gevher Akova on 26.06.2022.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let utl = Utils()
    var placesNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceId = ""

    @IBOutlet weak var placesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        placesTableView.delegate = self
        placesTableView.dataSource = self
        
        getDataFromParse()
    }
    
    @objc func addButtonClicked(){
        self.performSegue(withIdentifier: "toAddPlaceVc", sender: nil)
    }
    
    @objc func logoutButtonClicked(){
        PFUser.logOutInBackground { error in
            if error != nil {
                self.present(self.utl.showBasicAlert(tit: "Error!", msg: error?.localizedDescription ?? "Error!!"), animated: true)
            }else{
                self.performSegue(withIdentifier: "toSingUpVC", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placesNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesNameArray.count
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground{( objects, error) in
            if error != nil{
                self.present( self.utl.showBasicAlert(tit: "Error!", msg: error?.localizedDescription ?? "Error"), animated: true)
            }else{
                self.placeIdArray.removeAll()
                self.placeIdArray.removeAll()
                if objects != nil {
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String{
                            if let placeId = object.objectId{
                                self.placesNameArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                    }
                }
                
                self.placesTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC  = segue.destination as! DetailsVC
            destinationVC.chosenPlaceId = selectedPlaceId
        }
    }
}
