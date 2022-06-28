//
//  PlaceModel.swift
//  FoursquareCloneWithParse
//
//  Created by Erge Gevher Akova on 28.06.2022.
//

import Foundation
import UIKit

class AddPlaceModel {
    
    static let sharedInstance = AddPlaceModel()
    var placeName = ""
    var PlaceType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var latitude = ""
    var longitude = ""
    
    private init(){}
}
