//
//  ServiceProtocol.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation

typealias JSON = [String:Any]

protocol ServiceProtocol {
    associatedtype T
    func parse(_ data: GenericResponse, statusCode: ResponseStatusCode) -> T?
}
extension ServiceProtocol {
    typealias HandleServiceModel = (ServiceResponse<T>)
    
    func callService(url: String, header: [String:String],timeOut: TimeInterval, httpMethod: HTTPMethod,body: JSON, encode: EncodingProtocol = DictionaryEncode.shared, completion: @escaping(HandleServiceModel) -> Void ) {
        
        guard let url = URL(string: url) else { return completion(.badResquest) }
        
        var urlRequest = URLRequest(url: url.absoluteURL)
        urlRequest.timeoutInterval = timeOut
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = "GET"
        
        print("antes de URLSession method.........")
        print("URL:", url.absoluteString)
        print("header: ", header)
        print("urlRequest", urlRequest)
     

        URLSession(configuration: .ephemeral).dataTask(with: urlRequest) {
            (data, response, error) in
            guard let httpRespnse1 = response as? HTTPURLResponse else {return}
            let response = response as? HTTPURLResponse
            
            guard let httpRespnse = response, let statusMannaged = ResponseStatusCode(rawValue: httpRespnse.statusCode) else {
                //No se encontro peticion
                completion(.badResquest)
                return
            }

            DispatchQueue.main.async {
                switch statusMannaged {
                case .successCode: 
                    handlerSucccesRequest(data: data, statusCode: statusMannaged, error: error, completion: completion)
                case .badRequest, .notFound, .internalServerError: break
                case .errorRequest: break
                case .unauthorizedCode:break
                }
            }
            
        }.resume()
    }
    
    private func handlerSucccesRequest(data: Data?, statusCode: ResponseStatusCode, error: Error?, completion: @escaping(HandleServiceModel)->()) {
        if let model = parse(GenericResponse.parseResponse(code: statusCode.rawValue, data: data, error: error), statusCode: statusCode) {
            completion(.success(data: model))
        }
    }
}
