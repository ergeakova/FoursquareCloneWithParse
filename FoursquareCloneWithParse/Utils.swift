//
//  Utils.swift
//  FoursquareCloneWithParse
//
//  Created by Erge Gevher Akova on 26.06.2022.
//

import Foundation
import UIKit

class Utils{
    
    func showBasicAlert(tit: String, msg: String) ->UIAlertController{
        let alert = UIAlertController(title: tit, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        return alert
    }
    
    func isEmptyString(value: String) -> Bool{
        if value != "" {
            return true
        }else{
            return false
        }
    }
}
