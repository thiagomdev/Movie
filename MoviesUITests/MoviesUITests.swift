//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Thiago Monteiro on 13/10/24.
//

import XCTest
@testable import Movies

final class MoviesUITests: XCTestCase {
    func test_launch_home_ui() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.exists)
    }
}
