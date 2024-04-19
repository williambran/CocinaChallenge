//
//  CustomAnnotation.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import Foundation
import MapKit

class CustomAnnotation: MKPointAnnotation,  CustomMKPointAnnotationProtocol{
    var additionalInfo: String?
    var urlImg: String?
}

protocol CustomMKPointAnnotationProtocol: MKPointAnnotation {
    var additionalInfo: String? {get set}
    var urlImg: String? {get set}
}
