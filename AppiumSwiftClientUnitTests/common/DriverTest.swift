//
//  DriverTest.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
import AppiumSwiftClient
import Mockingjay

class DriverTest : XCTestCase {
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
        let driver = try! AppiumDriver(AppiumCapabilities(opts))

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
        let driver = try! AppiumDriver(AppiumCapabilities(opts))

        XCTAssertNotEqual(expected,
                          driver.currentSessionCapabilities.capabilities())
    }

    func testCreateSession() {
    }
}
