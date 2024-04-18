//
//  ServiceManagerTest.swift
//  CocinaChallengeTests
//
//  Created by William Brando Estrada Tepec on 17/04/24.
//

import XCTest
@testable import CocinaChallenge

final class ServiceManagerTest: XCTestCase {
    
    var sut: ServiceManagerProtocol!
        // var urlSession: URLSession!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: config)
        sut = ServiceManager(urlSession: urlSession)
    }

    override func tearDown() {
        sut = nil
        URLProtocolMock.mockResponse = nil
        super.tearDown()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRequest_whenGetSuccess_ReturnSuccesAndData() {
        let expectation = XCTestExpectation(description: "Espera una respuesta")
        let responseTestable = "{\"code\":\"100\",\"message\":\"success\",\"result\":{}}"
        let dataTestable: Data? = Data(responseTestable.utf8)
        let someURLResponse: URLResponse? = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let someError: Error? = nil

        URLProtocolMock.mockResponse = (data:dataTestable, response:someURLResponse , error:  someError)
        sut.request(url: "https://example.com", header: [:], timeOut: 5, httpMethod: .GET, body: JSON()) { (response :ServiceResponse<RecipesDTO> )  in
            switch response {
            case .success(data: _): expectation.fulfill()
            case .noSuccess(error: _): break
            case .badResquest: break
            case .notFound: break
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testRequest_whenGetBadRequest_ReturnBadResquest() {
        let expectation = XCTestExpectation(description: "Espera una respuesta")
        let someData: Data? = Data("Your data here".utf8)
        let someURLResponse: URLResponse? = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let someError: Error? = nil

        URLProtocolMock.mockResponse = (data:someData, response:someURLResponse , error:  someError)
        sut.request(url: "", header: [:], timeOut: 5, httpMethod: .GET, body: JSON()) { (response :ServiceResponse<RecipesDTO> )  in
            switch response {
            case .success(data: _): break
            case .noSuccess(error: _): break
            case .badResquest:
                expectation.fulfill()
            case .notFound: break
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testRequest_whenGetNotFound_ReturnBadNotFound() {
        let expectation = XCTestExpectation(description: "Espera una respuesta")
        let someData: Data? = Data("".utf8)
        let someURLResponse: URLResponse? = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        let someError: Error? = nil

        URLProtocolMock.mockResponse = (data:someData, response:someURLResponse , error:  someError)
        sut.request(url: "https://example.com", header: [:], timeOut: 5, httpMethod: .GET, body: JSON()) { (response :ServiceResponse<RecipesDTO> )  in
            switch response {
            case .success(data: _): break
            case .noSuccess(error: _): break
            case .badResquest: break
            case .notFound: expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
