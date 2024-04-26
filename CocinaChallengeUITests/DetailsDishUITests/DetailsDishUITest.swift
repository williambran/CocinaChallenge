//
//  DetailsDishUITest.swift
//  CocinaChallengeUITests
//
//  Created by William Brando Estrada Tepec on 26/04/24.
//

import XCTest

final class DetailsDishUITest: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        app = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_whenSelectItemDishAtHome_thenAppearDetailsItemDish() throws {
        
        let splasView = app.otherElements[AssessibilityIdentifier.splashViewIdentifier]
                XCTAssertTrue(splasView.waitForExistence(timeout: 1), "SplasView Not presented to init application")
        
        let homeView = app.otherElements[AssessibilityIdentifier.homeIdentifier]
        XCTAssertTrue(homeView.waitForExistence(timeout: 2), "Home View not presented to init successful process ")
        
        let collection = app.collectionViews.firstMatch
        XCTAssertNotNil(collection, "has not exist collection view")
        
        let firstCells = collection.cells.element(boundBy: 0)
        XCTAssertNotNil(firstCells, "has not exist Cell view")

        firstCells.tap()
        let detailsDish = app.otherElements[AssessibilityIdentifier.detailsDishViewIdentifier]
        XCTAssertTrue(detailsDish.waitForExistence(timeout: 4), "Details Dish View dont exist")
        

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_whenSelectItemDishResultSearchAtHome_thenAppearDetailsItemDish() throws {
        let query = "Tacos al Pastor"
        
        let splasView = app.otherElements[AssessibilityIdentifier.splashViewIdentifier]
                XCTAssertTrue(splasView.waitForExistence(timeout: 1), "SplasView Not presented to init application")
        
        let homeView = app.otherElements[AssessibilityIdentifier.homeIdentifier]
        XCTAssertTrue(homeView.waitForExistence(timeout: 2), "Home View not presented to init successful process ")
        
        let search = app.searchFields[AssessibilityIdentifier.searchCocina]
        XCTAssertTrue(search.waitForExistence(timeout: 4), "seacrh no exitst")
        
        search.tap()
        if !app.keys["A"].waitForExistence(timeout: 3) {
            XCTFail("The keyboard could not be found. Use keyboard shortcut COMMAND + SHIFT + K while simulator has focus on text input")
        }
        
        search.typeText(query)
        
        let existCellsTacos = app.collectionViews.cells.otherElements[AssessibilityIdentifier.contentViewRecetasIndentifier].staticTexts[query]
        
        XCTAssertTrue(existCellsTacos.waitForExistence(timeout: 5), "Dont have any record with the word Tacos al Pastor")
        
        existCellsTacos.tap()
        
        let detailsDish = app.otherElements[AssessibilityIdentifier.detailsDishViewIdentifier]
        XCTAssertTrue(detailsDish.waitForExistence(timeout: 4), "Details Dish View dont exist")
        

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

   /* func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }*/
}
