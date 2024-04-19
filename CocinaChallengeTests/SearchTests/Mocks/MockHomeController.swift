//
//  MockHomeController.swift
//  CocinaChallengeTests
//
//  Created by William Brando Estrada Tepec on 19/04/24.
//

import Foundation
@testable import CocinaChallenge



class MockHomeController: HomeHeaderDelegate {
    func didCancelSearch() {
    }
    
    func begingSearch() {
    }
    var searchingData:[DishesDTO] = []
    
    var searchCalled = false
    var searchFastCalled = false
    
    func search(_ query: String?) {
        searchCalled = true
    }
    
    func searchFast(_ query: String?) {
        searchFastCalled = true
    }
}
