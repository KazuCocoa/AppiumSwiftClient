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
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/test",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone",
            ]
        let driver = AppiumDriver(AppiumCapabilities(opts))

        let expectedJson = """
        {
            "capabilities": {
                "app": "path\\/to\\/test",
                "platformName": "iOS",
                "platformVersion": "11.4",
                "automationName": "xcuitest",
                "deviceName": "iPhone"
            },
            "desiredCapabilities": "caps1"
        }
        """
        let trimmedExpectedJson = String(expectedJson.filter { !" \n\t\r".contains($0) })

        XCTAssertEqual(trimmedExpectedJson, driver.sessionId)
    }
}
