//
//  ServiceManager.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 17/04/24.
//

import Foundation

typealias JSON = [String:Any]

protocol ServiceManagerProtocol {
    
    func request<T: Codable>(url: String, header: [String:String],timeOut: TimeInterval, httpMethod: HTTPMethod,body: JSON,  completion: @escaping(_ response: ServiceResponse<T>) -> Void )
}

class ServiceManager: ServiceManagerProtocol {
    
  
     var urlSession: URLSession
    
    init(urlSession: URLSession  ){
        self.urlSession = urlSession
    }
    
    func request<T: Codable>(url: String, header: [String : String], timeOut: TimeInterval, httpMethod: HTTPMethod, body: JSON, completion: @escaping (_ response: ServiceResponse<T>) -> Void) {

        guard let url = URL(string: url) else {
            return completion(.badResquest) }
        var urlRequest = URLRequest(url: url.absoluteURL)
        urlRequest.timeoutInterval = timeOut
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = httpMethod.rawValue
       
        urlSession.dataTask(with: urlRequest) {
            (data, response, error) in
            let response = response as? HTTPURLResponse
            guard let httpRespnse = response, let statusMannaged = ResponseStatusCode(rawValue: httpRespnse.statusCode) else {
                completion(.notFound)
                return
            }

            DispatchQueue.main.async {
                switch statusMannaged {
                case .successCode:
                    self.handlerSucccesRequest(data: data, statusCode: statusMannaged, error: error, completion: completion)
                case .badRequest:
                    completion(.badResquest)
                case  .notFound:
                    completion(.notFound)
                case .errorRequest:
                    completion(.noSuccess(error: self.parseError(errorCode: statusMannaged)))
                case .internalServerError:
                    completion(.notFound)
                case .unauthorizedCode:
                    completion(.noSuccess(error: self.parseError(errorCode: statusMannaged)))
                }
            }
            
        }.resume()
        
    }
    
    private func handlerSucccesRequest<T: Codable>(data: Data?, statusCode: ResponseStatusCode, error: Error?, completion: @escaping(ServiceResponse<T>)->()) {
        if let model: T = parse(data: GenericResponse.parseResponse(code: statusCode.rawValue ,data: data, error: error)) {
            completion(.success(data: model))
        }
    }
    
    func parse<T:Codable>(data: GenericResponse) -> T? {
        guard let json = data.resultJson , let recetasData = try? JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: json)) else {
            return nil }
        return recetasData
    }
    
    func parseError(errorCode: ResponseStatusCode) -> GenericResponse {
        let recetasData = GenericResponse.processError(code: errorCode.rawValue)
        return recetasData
    }
}
