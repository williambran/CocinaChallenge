//
//  CocinaChallengeUITests.swift
//  CocinaChallengeUITests
//
//  Created by William Brando Estrada Tepec on 12/04/24.
//

import XCTest

final class CocinaChallengeUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }



    func test_whenInitialApp_AppearSplashFlow() {
        let splasView = app.otherElements[AssessibilityIdentifier.splashViewIdentifier]
                XCTAssertTrue(splasView.waitForExistence(timeout: 1), "SplasView Not presented to init application")
    }
    
    func test_WhenInitialiceSuccessApp_AppearHomeFlow() {
        let homeView = app.otherElements[AssessibilityIdentifier.homeIdentifier]
        XCTAssertTrue(homeView.waitForExistence(timeout: 2), "Home View not presented to init successful process ")
    }
    
    func test_WhenTriedSearchDishTacoIntoSearchFieldWithPressSearch_thenAppWillShowListOfMatch() {
        let query = "Tacos al Pastor"
        let search = app.searchFields[AssessibilityIdentifier.searchCocina]
        XCTAssertTrue(search.waitForExistence(timeout: 4), "seacrh no exitst")
        
        search.tap()
        if !app.keys["A"].waitForExistence(timeout: 3) {
            XCTFail("The keyboard could not be found. Use keyboard shortcut COMMAND + SHIFT + K while simulator has focus on text input")
        }
        search.typeText(query)
        //Take capture on searchField
        let screenSearch = search.screenshot()
        let currentAppWindowattachment = XCTAttachment(screenshot: screenSearch)
        currentAppWindowattachment.name = "Search ScreenShot wito"
        currentAppWindowattachment.lifetime = .keepAlways
        add(currentAppWindowattachment)
        
        let existCellsTacos = app.collectionViews.cells.otherElements[AssessibilityIdentifier.contentViewRecetasIndentifier].staticTexts[query].waitForExistence(timeout: 5)
       
        //take capture
        let currentView = XCUIScreen.main.screenshot()
        let currentAppWindowAttachement = XCTAttachment(screenshot: currentView)
        currentAppWindowAttachement.name = "Pruebas de busqueda wito"
        currentAppWindowAttachement.lifetime = .keepAlways
        add(currentAppWindowAttachement)
        
        XCTAssertTrue(existCellsTacos, "Dont have any record with the word Tacos al Pastor")
        
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
