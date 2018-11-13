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
            DesiredCapabilitiesEnum.reduceMotion: "true"
        ]
        let driver = AppiumDriver(AppiumCapabilities(opts))
        XCTAssert(driver.currentSessionCapabilities.capabilities()[.sessionId] != "")

        let el = try! driver.findElement(by: SearchContext.AccessibilityId, with: "Buttons")
        XCTAssert(el.id != "")
        print(el.id)

        el.click()

        let buttonGray = try! driver.findElement(by: SearchContext.Name, with: "Gray")
        XCTAssert(buttonGray.id != "NoSuchElementError")

        XCTAssertThrowsError((try driver.findElement(by: SearchContext.Name, with: "Grey"))) { error in
            guard case WebDriverErrorEnum.NoSuchElementError(let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual("no such element", error["error"])
            XCTAssertEqual("An element could not be located on the page using the given search parameters.", error["message"])
        }
    }
}
