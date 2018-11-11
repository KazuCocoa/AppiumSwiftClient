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
    func skip_testDriverInitializationWithW3CFormat() {
        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/test",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone",
        ]
        let generatedJson = AppiumDriver(AppiumCapabilities(opts)).generateCapabilityBody(with: AppiumCapabilities(opts))

        let expectedJson = """
        {
            "capabilities": {
                "firstMatch": [{
                    "appium:app": "path\\/to\\/test",
                    "automationName": "xcuitest",
                    "deviceName": "iPhone",
                    "platformName": "iOS",
                    "platformVersion": "11.4"
                }]
            },
            "desiredCapabilities": {
                "app": "path\\/to\\/test",
                "automationName": "xcuitest",
                "deviceName": "iPhone",
                "platformName": "iOS",
                "platformVersion": "11.4"
            }
        }
        """
        let trimmedExpectedJson = String(expectedJson.filter { !" \n\t\r".contains($0) })

        XCTAssertEqual(trimmedExpectedJson, generatedJson)
    }

    func skip_testDriverInitialization() {
        let expected = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/test",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone",
            DesiredCapabilitiesEnum.sessionId: "session id"
        ]

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/test",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone",
        ]
        let driver = AppiumDriver(AppiumCapabilities(opts))

        XCTAssertEqual(expected,
                       driver.currentSessionCapabilities.capabilities())
    }

    func skip_testFailedToDriverInitialization() {
        let expected = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/test",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone",
            DesiredCapabilitiesEnum.sessionId: "session failed"
        ]

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/test",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone",
        ]
        let driver = AppiumDriver(AppiumCapabilities(opts))

        XCTAssertNotEqual(expected,
                          driver.currentSessionCapabilities.capabilities())
    }

    func testCreateSession() {
        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "/Users/kazuaki/GitHub/ruby_lib_core/test/functional/app/UICatalog.app.zip",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone Simulator",
        ]
        let driver = AppiumDriver(AppiumCapabilities(opts))
        XCTAssert(driver.currentSessionCapabilities.capabilities()[.sessionId] != "")
    }
}
