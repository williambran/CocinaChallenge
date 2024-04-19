//
//  LocationOriginDto.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 18/04/24.
//

import Foundation


struct LocationOriginDto: Codable, Hashable {
    var name: String?
    var descriptionPlace: String?
    var description: String?
    var urlImg: String?
    var longitude: String?
    var latitude: String?
    
    var longitudePoint: Double {
        return Double(longitude ?? "0.0") ?? 0.0
    }
    var latitudePoint: Double {
        return Double(latitude ?? "0.0") ?? 0.0
    }
}
