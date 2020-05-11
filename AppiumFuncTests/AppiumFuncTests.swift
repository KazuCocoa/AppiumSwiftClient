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

    var driver: AppiumDriver!

    override func setUp() {
        let packageRootPath = URL(
            fileURLWithPath: #file.replacingOccurrences(of: "AppiumFuncTests/AppiumFuncTests.swift", with: "")
            ).path

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "\(packageRootPath)/AppiumFuncTests/app/UICatalog.app.zip",
            DesiredCapabilitiesEnum.platformVersion: "13.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone 8",
            DesiredCapabilitiesEnum.reduceMotion: "true"
        ]
        do {
            driver = try AppiumDriver(AppiumCapabilities(opts))
        } catch {
            XCTFail("Failed to spin up driver: \(error)")
        }
    }

    override func tearDown() {
        driver.quit()
    }

    func testDriverSessionCapabilities() {
        XCTAssert(driver.currentSessionCapabilities.capabilities()[.sessionId] != "")

        XCTAssertNotNil(driver.getCapabilities()["udid"])

        XCTAssertEqual(driver.getAvailableContexts(), ["NATIVE_APP"])
        XCTAssertNotNil(try driver.setContext(name: "NATIVE_APP"))
        XCTAssertEqual(driver.getCurrentContext(), "NATIVE_APP")
    }

    func testCanFindElements() {
        do {
            let els = try driver.findElements(by: .accessibilityId, with: "Buttons")
            XCTAssertEqual(els.count, 1)
            XCTAssert(els[0].id != "")
        } catch let exception {
            XCTFail("\(exception)")
        }
    }

    func testCanFindElement() {
        do {
            let ele = try driver.findElement(by: .accessibilityId, with: "Buttons")
            XCTAssert(ele.id != "")
        } catch let exception {
            XCTFail("\(exception)")
        }
    }

    func testCanTakeScreenshotOfElement() {
        do {
            let ele = try driver.findElement(by: .accessibilityId, with: "Buttons")
            let elementScreenshotPath = driver.saveScreenshot(with: ele, to: "element_screenshot.png")
            XCTAssertNotEqual(elementScreenshotPath, "")
        } catch let exception {
            XCTFail("\(exception)")
        }
    }

    func testCanTakeScreenshotOfFullScreen() {
        let screenshotPath = driver.saveScreenshot(to: "hello.png")
        XCTAssertNotEqual(screenshotPath, "")
    }

    func testCantFindInexistentElement() {
        do {
            let ele = try driver.findElement(by: .accessibilityId, with: "Buttons")
            ele.click()
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
        } catch let exception {
            XCTFail("\(exception)")
        }
    }

    func testCanGetPageSource() {
        do {
            let pageSource = try driver.getPageSource()
            XCTAssertTrue(pageSource.contains("<?xml version=\"1.0\" encoding=\"UTF-8\"?><AppiumAUT>"))
        } catch let exception {
            XCTFail("\(exception)")
        }
    }

    func testCanGoBack() {
        do {
            let ele = try driver.findElement(by: .accessibilityId, with: "Buttons")
            let firstViewSource = try driver.getPageSource()
            ele.click()
            let nextPageSource = try driver.getPageSource()
            XCTAssertTrue(firstViewSource != nextPageSource)
            try driver.back()
            let firstViewSourceAfterGoBack = try driver.getPageSource()
            XCTAssertTrue(firstViewSource == firstViewSourceAfterGoBack)
            // TODO GF 05.05.2020: This test is suboptimal in my opinion and should be refactored once Element related endpoints are implemented to take advantage of visibility command.
        } catch let exception {
            XCTFail("\(exception)")
        }
    }

    func testImplicitTimeout() {
        var deltaWithoutImplicitWait: Double = 0
        let initTimeWithoutImplicitWait = NSDate().timeIntervalSince1970
        do {
            _ = try driver.findElement(by: .name, with: "Bogus Element")
        } catch {
            deltaWithoutImplicitWait = NSDate().timeIntervalSince1970 - initTimeWithoutImplicitWait
        }
        try! driver.setImplicitTimeout(timeoutInMillisencods: 300) // swiftlint:disable:this force_try
        var deltaWithImplicitWait: Double = 0
        let initTimeWithImplicitWait = NSDate().timeIntervalSince1970
        do {
            _ = try driver.findElement(by: .name, with: "Bogus Element")
        } catch {
            deltaWithImplicitWait = NSDate().timeIntervalSince1970 - initTimeWithImplicitWait
        }
        XCTAssertTrue((deltaWithImplicitWait - deltaWithoutImplicitWait) > 0.3)
    }

    func testCanGetScreenOrientation() {
        do {
            let screenOrientation = try driver.getScreenOrientation()
            print(screenOrientation)
            XCTAssertTrue(screenOrientation == "PORTRAIT")
        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testCantSetScreenOrientationIfAppIsPortraitOnly() {
        do {
            try driver.rotate(to: ScreenOrientationEnum.landscape)
        } catch let error {
            XCTAssertTrue(error is WebDriverErrorEnum)
        }
    }
}
