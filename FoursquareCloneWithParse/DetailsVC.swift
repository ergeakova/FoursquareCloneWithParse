//
//  DetailsVC.swift
//  FoursquareCloneWithParse
//
//  Created by Erge Gevher Akova on 27.06.2022.
//

import UIKit
import MapKit

class DetailsVC: UIViewController {

    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var lblPlaceType: UILabel!
    @IBOutlet weak var lblPlaceAtmosphere: UILabel!
    @IBOutlet weak var detailsMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPlaceAtmosphere.text = ""
        // Do any additional setup after loading the view.
    }
}
