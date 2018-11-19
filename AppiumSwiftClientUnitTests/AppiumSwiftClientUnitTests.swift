//
//  AppiumSwiftClientUnitTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
@testable import AppiumSwiftClient

class AppiumSwiftClientUnitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func skip_testAppiumSwiftClientUnitTests() {
        let packageRootPath = URL(
            fileURLWithPath: #file.replacingOccurrences(of: "AppiumSwiftClientUnitTests/common/DriverTest.swift", with: "")
            ).path

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "\(packageRootPath)/AppiumSwiftClientUnitTests/app/UICatalog.app.zip",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone 8",
            DesiredCapabilitiesEnum.reduceMotion: "true"
        ]

        do {
            let driver = try AppiumDriver(AppiumCapabilities(opts))
            XCTAssert(driver.currentSessionCapabilities.capabilities()[.sessionId] != "")

            XCTAssertNotNil(driver.getCapabilities()["udid"])

            let els = try driver.findElements(by: SearchContext.accessibilityId, with: "Buttons")
            XCTAssertEqual(els.count, 1)
            XCTAssert(els[0].id != "")

            let el = try driver.findElement(by: SearchContext.accessibilityId, with: "Buttons")
            XCTAssert(el.id != "")

            el.click()

            let buttonGray = try driver.findElement(by: SearchContext.name, with: "Gray")
            XCTAssert(buttonGray.id != "NoSuchElementError")

            XCTAssertEqual((try driver.findElements(by: SearchContext.accessibilityId, with: "Grey")).count, 0)

            XCTAssertThrowsError((try driver.findElement(by: SearchContext.name, with: "Grey"))) { error in
                guard case WebDriverErrorEnum.noSuchElementError(let error) = error else {
                    return XCTFail()
                }
                XCTAssertEqual("no such element", error["error"])
                XCTAssertEqual("An element could not be located on the page using the given search parameters.", error["message"])
            }
        } catch let e {
            // TODO: We must prepare a wrapper of assertions in order to make where the error happens clear
            XCTAssertFalse(true, "\(e)")
        }
    }
}
