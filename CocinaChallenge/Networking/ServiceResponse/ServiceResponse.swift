//
//  ServiceResponse.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation


enum ServiceResponse<T>{
    case success(data: T)
    case noSuccess(error: GenericResponse)
    case notFound
    case badResquest
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

/* Agregar los codigos de respiuestas que se requieran recibior*/
enum ResponseStatusCode: Int {
    case successCode = 200
    case badRequest = 400
    case unauthorizedCode = 401
    case notFound = 404
    case internalServerError = 500
    case errorRequest
    
    
    static func getStatusForCode(_ rawValue: Int) -> ResponseStatusCode {
        switch rawValue {
        case 200: return .successCode
        case 201: return .successCode
        case 400: return .badRequest
        case 401: return .unauthorizedCode
        case 404: return .notFound
        case 500: return .internalServerError
        default:
            return .errorRequest
        }
    }
}
