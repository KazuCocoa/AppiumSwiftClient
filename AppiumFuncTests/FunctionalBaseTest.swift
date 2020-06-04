//
//  FunctionalBaseTest.swift
//  AppiumFuncTests
//
//  Created by Gabriel Fioretti on 11.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
@testable import AppiumSwiftClient

open class FunctionalBaseTest: XCTestCase {

    var driver: AppiumDriver!
    var desiredCapabilities: [DesiredCapabilitiesEnum: String]!

    open override func setUp() {
        do {
            driver = try AppiumDriver(AppiumCapabilities(desiredCapabilities))
        } catch {
            XCTFail("Failed to spin up driver: \(error)")
        }
    }

    open override func tearDown() {
        do {
            try driver.quit()
        } catch {
            XCTFail("Failed to quit driver: \(error)")
        }
    }
}
