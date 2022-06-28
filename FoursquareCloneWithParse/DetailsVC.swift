//
//  DetailsVC.swift
//  FoursquareCloneWithParse
//
//  Created by Erge Gevher Akova on 27.06.2022.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {

    var utl = Utils()
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var lblPlaceType: UILabel!
    @IBOutlet weak var lblPlaceAtmosphere: UILabel!
    @IBOutlet weak var detailsMap: MKMapView!
    
    var chosenPlaceId = ""
    var chosenlatitude = Double()
    var chosenlongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground{ (objects, error) in
            if error != nil {
                self.present( self.utl.showBasicAlert(tit: "Error!", msg: error?.localizedDescription ?? "Error"), animated: true)
            }else{
                if objects != nil {
                    let chosenObject = objects![0]
                    if let placeName = chosenObject.object(forKey: "name") as? String{
                        self.lblPlaceName.text = placeName
                    }
                    
                    if let placeType = chosenObject.object(forKey: "type") as? String{
                        self.lblPlaceType.text = placeType
                    }
                    
                    if let placeAtmosphere = chosenObject.object(forKey: "atmosphere") as? String{
                        self.lblPlaceAtmosphere.text = placeAtmosphere
                    }
                    
                    if let placeLatitude = chosenObject.object(forKey: "lat") as? String{
                        if let latDouble = Double(placeLatitude) {
                            self.chosenlatitude = latDouble
                        }
                    }

                    if let placeLongitude = chosenObject.object(forKey: "long") as? String {
                        if let longDouble = Double(placeLongitude){
                            self.chosenlongitude = longDouble
                        }
                    }
                    
                    if let imageData = chosenObject.object(forKey: "image") as? PFFileObject {
                        imageData.getDataInBackground{ (data, error) in
                            if error == nil {
                                if data != nil {
                                    self.detailsImage.image = UIImage(data: data!)
                                }
                            }
                        }
                    }
        
                    self.showMapDetails()
                }
            }
        }
    }
    
    func showMapDetails(){
        let location = CLLocationCoordinate2D(latitude: self.chosenlatitude, longitude: self.chosenlongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        self.detailsMap.setRegion(region, animated: true)
        let anotation = MKPointAnnotation()
        
        anotation.coordinate = location
        anotation.title = self.lblPlaceName.text!
        anotation.subtitle = self.lblPlaceType.text!
        self.detailsMap.addAnnotation(anotation)
    }
}
