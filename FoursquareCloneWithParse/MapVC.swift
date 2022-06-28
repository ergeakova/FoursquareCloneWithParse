//
//  MapVC.swift
//  FoursquareCloneWithParse
//
//  Created by Erge Gevher Akova on 27.06.2022.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var utl = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonCliked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        let recongizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLoction(gestureRecongizer:)))
        mapView.addGestureRecognizer(recongizer)
    }
    
    @objc func chooseLoction(gestureRecongizer: UIGestureRecognizer){
        if gestureRecongizer.state == UIGestureRecognizer.State.began {
            let touches = gestureRecongizer.location(in: self.mapView)
            let coordinates = self.mapView.convert( touches, toCoordinateFrom: self.mapView)
            
            let annotation  = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = AddPlaceModel.sharedInstance.placeName
            annotation.subtitle = AddPlaceModel.sharedInstance.PlaceType
            
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            self.mapView.addAnnotation(annotation)
            
            AddPlaceModel.sharedInstance.latitude = String(coordinates.latitude)
            AddPlaceModel.sharedInstance.longitude = String(coordinates.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func saveButtonCliked(){
        
        let placemodel = AddPlaceModel.sharedInstance
        
        let object = PFObject(className: "Places")
        object["name"] = placemodel.placeName
        object["type"] = placemodel.PlaceType
        object["atmosphere"] = placemodel.placeAtmosphere
        object["lat"] = placemodel.latitude
        object["long"] = placemodel.longitude

        if let imageData = placemodel.placeImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFileObject(data: imageData)
        }
        
        object.saveInBackground{ (succes, error) in
            if error != nil {
                self.present( self.utl.showBasicAlert(tit: "Error!", msg: error?.localizedDescription ?? "Place could not be loaded!"), animated: true )
            }else {
                self.performSegue(withIdentifier: "FromMapVCtoPlacesVC", sender: nil)
            }
        }
    }
    @objc func backButtonClicked(){
        self.dismiss(animated: true)
    }
}
