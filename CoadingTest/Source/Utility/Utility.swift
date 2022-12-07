//
//  Utility.swift
//  CoadingTest
//
//  Created by Hiren  Patel on 12/6/22.
//

import Foundation
import UIKit

class Utility {
    // MARK: - Show Alert Generic Method
    class func showErrorAlert(with message: String, controller:UIViewController) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
