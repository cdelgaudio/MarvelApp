//
//  MarvelAppUITests.swift
//  MarvelAppUITests
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import XCTest

class MarvelAppUITests: XCTestCase {

    func testExample() {
        let app = XCUIApplication()
        app.launch()
      
      XCTAssert(app.navigationBars["Comic List"].exists, "Wrong first screen UITest")
      app.collectionViews.children(matching: .cell)
        .element(boundBy: 0).otherElements.element(boundBy: 0).tap()
      XCTAssert(app.navigationBars["Comic Details"].exists, "Wrong second screen UITest")
    }

}
