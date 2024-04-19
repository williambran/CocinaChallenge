//
//  SeachingDishTests.swift
//  CocinaChallengeTests
//
//  Created by William Brando Estrada Tepec on 19/04/24.
//

import XCTest
@testable import CocinaChallenge


final class SeachingDishTests: XCTestCase {

    var sut: HomeScreenViewController?
    var dataSource: [DishesDTO]?
    
    override func setUpWithError() throws {
        sut = HomeScreenViewController.instantiate(from: "HomeScreenViewController" )
        sut?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {

    }
    func testExample() throws {
  
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testSearch() throws {
        
        let HomeHeadView = try XCTUnwrap(sut?.homeHeaderView )
        
    }

    
    func testSearch_cuandoIniciamosControlador_esperamosStatusINACTIVE() {
        let mockController = sut

        mockController?.searchingData = [DishesDTO(name: "papas")]
        let status = mockController?.statusSearch
        mockController?.search("papas")
        XCTAssertEqual(status, .INACTIVE, "Data source should contain one item")
    }

    func testSearch_cuandoIniciamosControlador_esperamosS() {
        
        let expectation = XCTestExpectation(description: "Espera una respuesta")
        sut?.searchingData = [DishesDTO(name: "papas")]
        sut?.dataSource = sut!.searchingData
        let status = sut?.statusSearch
        let callBack = sut?.reloadCallback
        sut?.reloadDataCompletion(completion: {
            let acount = self.sut?.dataSource.count
            print("acount::::", acount)
            XCTAssertGreaterThanOrEqual(acount!, 1, "Respuesta Correcta")
            expectation.fulfill()
        })
        sut?.search("papas")
        
        wait(for: [expectation], timeout: 10)


    }

}
