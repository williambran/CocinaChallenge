//
//  URLProtocolMock.swift
//  CocinaChallengeTests
//
//  Created by William Brando Estrada Tepec on 17/04/24.
//

import Foundation

class URLProtocolMock: URLProtocol {
    
    static var mockResponse: (data: Data?, response: URLResponse?, error: Error?)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let mockResponse = URLProtocolMock.mockResponse {
            if let data = mockResponse.data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            if let response = mockResponse.response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }/*
            if let error = mockResponse.error {
                // Informa al cliente sobre el error
                self.client?.urlProtocol(self, didFailWithError: error)
            }*/
        }
 
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
