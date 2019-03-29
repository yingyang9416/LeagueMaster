//
//  UIViewController+Helper.swift
//  LeagueMaster
//
//  Created by Ying Yang on 3/28/19.
//  Copyright © 2019 Ying Yang. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertWith(title: String? = "Oops...", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
