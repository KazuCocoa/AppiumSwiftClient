//
//  AppiumFuncTests.swift
//  AppiumFuncTests
//
//  Created by kazuaki matsuo on 2018/11/19.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
@testable import AppiumSwiftClient

class AppiumFuncTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppiumSwiftClientUnitTests() {
        let packageRootPath = URL(
            fileURLWithPath: #file.replacingOccurrences(of: "AppiumFuncTests/AppiumFuncTests.swift", with: "")
            ).path

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "\(packageRootPath)/AppiumFuncTests/app/UICatalog.app.zip",
            DesiredCapabilitiesEnum.platformVersion: "13.3",
            DesiredCapabilitiesEnum.deviceName: "iPhone 8",
            DesiredCapabilitiesEnum.reduceMotion: "true"
        ]

        do {
            let driver = try AppiumDriver(AppiumCapabilities(opts))
            XCTAssert(driver.currentSessionCapabilities.capabilities()[.sessionId] != "")

            XCTAssertNotNil(driver.getCapabilities()["udid"])

            XCTAssertEqual(driver.getAvailableContexts(), ["NATIVE_APP"])
            XCTAssertNotNil(try driver.setContext(name: "NATIVE_APP"))
            XCTAssertEqual(driver.getCurrentContext(), "NATIVE_APP")

            let els = try driver.findElements(by: .accessibilityId, with: "Buttons")
            XCTAssertEqual(els.count, 1)
            XCTAssert(els[0].id != "")

            let ele = try driver.findElement(by: .accessibilityId, with: "Buttons")
            XCTAssert(ele.id != "")

            let elementScreenshotPath = driver.saveScreenshot(with: ele, to: "element_screenshot.png")
            XCTAssertNotEqual(elementScreenshotPath, "")
            print(elementScreenshotPath)

            _ = ele.click()

            let buttonGray = try driver.findElement(by: .name, with: "Gray")
            XCTAssert(buttonGray.id != "NoSuchElementError")

            XCTAssertEqual((try driver.findElements(by: .accessibilityId, with: "Grey")).count, 0)

            XCTAssertThrowsError((try driver.findElement(by: .name, with: "Grey"))) { error in
                guard case WebDriverErrorEnum.noSuchElementError(let error) = error else {
                    return XCTFail("should raise no such element error")
                }
                XCTAssertEqual("no such element", error.error)
                XCTAssertEqual("An element could not be located on the page using the given search parameters.",
                               error.message)
            }

            let screenshotPath = driver.saveScreenshot(to: "hello.png")
            XCTAssertNotEqual(screenshotPath, "")
            print(screenshotPath)
            _ = driver.quit()
        } catch let exception {
            // TODO: We must prepare a wrapper of assertions in order to make where the error happens clear
            XCTAssertFalse(true, "\(exception)")
        }
    }
}
