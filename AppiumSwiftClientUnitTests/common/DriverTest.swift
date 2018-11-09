//
//  DriverTest.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
import AppiumSwiftClient

class DriverTest : XCTestCase {
    func testDriverInitialization() {
        let opts = [
            DesiredCapabilities.platformName: "iOS",
            DesiredCapabilities.automationName: "xcuitest",
            DesiredCapabilities.app: "path/to/test",
            DesiredCapabilities.platformVersion: "11.4",
            DesiredCapabilities.deviceName: "iPhone Simulator",
            ]
        let driver = AppiumDriver(AppiumCapabilities(opts))

        XCTAssertEqual("{\"capabilities\":\"caps2\",\"desiredCapabilities\":\"caps1\"}", driver.sessionId)
    }
}
