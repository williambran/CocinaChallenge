//
//  UIViewExtension.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation
import UIKit


protocol ReuseIdentifier {}

extension ReuseIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: ReuseIdentifier {}

extension Data {
    var toJSON: JSON? {
        return try? JSONSerialization.jsonObject(with: self,options: []) as? JSON
    }
}
