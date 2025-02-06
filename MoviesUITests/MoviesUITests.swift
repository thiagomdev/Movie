//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Thiago Monteiro on 26/01/25.
//

import XCTest
import FBSnapshotTestCase
@testable import Movies

final class MoviesUITests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_viewController() {
        let coordinator = HomeCoordinator(navigation: .init())
        let viewController = HomeFactory.make(coordinator: coordinator)
        FBSnapshotVerifyViewController(viewController, identifier: "Movies")
    }
}
