//
//  UIButtonExtension.swift
//  DidURead
//
//  Created by Ahmet Engin Gökçe on 17.10.2021.
//

import Foundation
import UIKit

extension UIButton {
    func chosenButtonColor() {
        self.backgroundColor = UIColor(red: 255/255, green: 149/255, blue: 0, alpha: 1)
    }
    func notChosenButtonColor() {
        self.backgroundColor = UIColor(red: 255/255, green: 181/255, blue: 53/255, alpha: 1)
    }
    
}
