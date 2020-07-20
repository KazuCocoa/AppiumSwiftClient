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
    var homeScreen: HomeScreen!
    var textFieldsScreen: TextFieldsScreen!
    var buttonsScreen: ButtonsScreen!
    var segmentsScreen: SegmentsScreen!

    override func setUp() {
        let packageRootPath = URL(
            fileURLWithPath: #file.replacingOccurrences(of: "AppiumFuncTests/AppiumDriver/AppiumFuncTests.swift", with: "")
            ).path

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "\(packageRootPath)/AppiumFuncTests/app/UICatalog.app.zip",
            DesiredCapabilitiesEnum.platformVersion: "13.6",
            DesiredCapabilitiesEnum.deviceName: "iPhone 8",
            DesiredCapabilitiesEnum.reduceMotion: "true"
        ]
        do {
            driver = try AppiumDriver(AppiumCapabilities(opts))
            homeScreen = HomeScreen(driver)
            textFieldsScreen = TextFieldsScreen(driver)
            buttonsScreen = ButtonsScreen(driver)
            segmentsScreen = SegmentsScreen(driver)
        } catch {
            XCTFail("Failed to spin up driver: \(error)")
        }
    }

    override func tearDown() {
        do {
            try driver.quit().get()
        } catch {
            XCTFail("Failed to quit driver: \(error)")
        }
    }

    func testDriverSessionCapabilities() {
        XCTAssert(driver.currentSessionCapabilities.capabilities()[.sessionId] != "")

        let capabilities = try! driver.getCapabilities().get()

        XCTAssertNotNil(capabilities.udid)

        XCTAssertEqual(try driver.getAvailableContexts().get(), ["NATIVE_APP"])
        XCTAssertNotNil(try driver.setContext(name: "NATIVE_APP"))
        XCTAssertEqual(try driver.getCurrentContext().get(), "NATIVE_APP")
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
            let elementScreenshotPath = try ele.saveScreenshot(to: "element_screenshot.png")
            XCTAssertNotEqual(elementScreenshotPath, "")
        } catch let exception {
            XCTFail("\(exception)")
        }
    }

    func testCanTakeScreenshotOfFullScreen() {
        do {
            let screenshotPath = try driver.saveScreenshot(to: "hello.png")
            XCTAssertNotEqual(screenshotPath, "")
        } catch let exception {
            XCTFail("\(exception)")
        }
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
            let pageSource = try driver.getPageSource().get()
            XCTAssertTrue(pageSource.contains("<?xml version=\"1.0\" encoding=\"UTF-8\"?><AppiumAUT>"))
        } catch let exception {
            XCTFail("\(exception)")
        }
    }

    func testCanGoBack() {
        do {
            let ele = try driver.findElement(by: .accessibilityId, with: "Buttons")
            let firstViewSource = try driver.getPageSource().get()
            ele.click()
            let nextPageSource = try driver.getPageSource().get()
            XCTAssertTrue(firstViewSource != nextPageSource)
            driver.back()
            let firstViewSourceAfterGoBack = try driver.getPageSource().get()
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
        driver.setImplicitTimeout(timeoutInMillisencods: 300) // swiftlint:disable:this force_try
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
            let screenOrientation = try driver.getScreenOrientation().get()
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

    func testCanGetAvailableLogTypes() {
        do {
            let availableLogTypes = try driver.getAvailableLogTypes().get()
            XCTAssertFalse(availableLogTypes.isEmpty)
            print(availableLogTypes)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testCanLogCustomEventsAndRetreiveEvents() {
        let events = try? driver.getEvents()
        guard let countBefore = events?.events.count else { return }
        driver.logEvent(with: "Appium", and: "funEvent")
        let eventsAfter = try? driver.getEvents()
        guard let countAfter = eventsAfter?.events.count else { return }
        XCTAssertTrue(countAfter > countBefore)
    }

    func testCanTypeTextOntoTextField() {
        homeScreen.textFieldsBtn().click()
        textFieldsScreen.roundedTextField().click()
        let text = "Send Keys Test"
        textFieldsScreen.roundedTextField().sendKeys(with: text)
        // TODO: refactor this assertion once https://appium.io/docs/en/commands/element/attributes/text/ is implemented
        XCTAssertTrue(try! driver.getPageSource().get().contains(text))
    }

    func testCanTypeUnicode() {
        homeScreen.textFieldsBtn().click()
        textFieldsScreen.roundedTextField().click()
        let emoji = "🤷"
        textFieldsScreen.roundedTextField().sendKeys(with: emoji)
        XCTAssertTrue(try! driver.getPageSource().get().contains(emoji))
    }

    func testCantTypeTextOntoInvalidElements() {
        XCTAssertThrowsError((try homeScreen.buttonsBtn().sendKeys(with: "Should Fail").get())) { error in
            guard case WebDriverErrorEnum.invalidElementStateError(let error) = error else {
                return XCTFail("should raise invalid element state error")
            }
            XCTAssertEqual("invalid element state", error.error)
        }

        XCTAssertThrowsError((try buttonsScreen.grayBtn().sendKeys(with: "Should Fail").get())) { error in
            guard case WebDriverErrorEnum.invalidElementStateError(let error) = error else {
                return XCTFail("should raise invalid element state error")
            }
            XCTAssertEqual("invalid element state", error.error)
        }
    }

    func testCanClearTextValue() {
        homeScreen.textFieldsBtn().click()
        textFieldsScreen.roundedTextField().click()
        let text = "Send Keys Test"
        textFieldsScreen.roundedTextField().sendKeys(with: text)
        textFieldsScreen.roundedTextField().clear()
        let pageSourceAfterClear = try! driver.getPageSource().get()
        XCTAssertFalse(pageSourceAfterClear.contains(text))
    }

    func testCanGetButtonText() {
        let text = try? homeScreen.buttonsBtn().getText()
        XCTAssertEqual(text, "Buttons")
    }

    func testCanGetTextFromTextBox() {
        homeScreen.textFieldsBtn().click()
        let testText = "Test Text"
        textFieldsScreen.roundedTextField().click()
        textFieldsScreen.roundedTextField().sendKeys(with: testText)
        let text = try? textFieldsScreen.roundedTextField().getText()
        XCTAssertEqual(text, testText)
    }

    func testCanGetButtonTagName() {
        let tagName = try? homeScreen.buttonsBtn().getTagName()
        XCTAssertEqual(tagName, "XCUIElementTypeStaticText")
    }

    func testCanGetTagNameOfTextBox() {
        homeScreen.textFieldsBtn().click()
        let tagName = try? textFieldsScreen.roundedTextField().getTagName()
        XCTAssertEqual(tagName, "XCUIElementTypeTextField")
    }

    func testCanGetButtonAttribute() {
        let type = try? homeScreen.textFieldsBtn().getElementAttribute(with: "type")
        let value = try? homeScreen.textFieldsBtn().getElementAttribute(with: "value")
        let name = try? homeScreen.textFieldsBtn().getElementAttribute(with: "name")
        let label = try? homeScreen.textFieldsBtn().getElementAttribute(with: "label")
        let enabled = try? homeScreen.textFieldsBtn().getElementAttribute(with: "enabled")
        XCTAssertEqual(type, "XCUIElementTypeStaticText")
        XCTAssertEqual(value, "TextFields")
        XCTAssertEqual(name, "TextFields")
        XCTAssertEqual(label, "TextFields")
        XCTAssertEqual(enabled, "true")
    }

    func testCanGetElementSelected() {
        homeScreen.segmentsBtn().click()
        XCTAssertFalse(try! segmentsScreen.checkBtn().isSelected())
        XCTAssertTrue(try! segmentsScreen.searchBtn().isSelected())
    }

    func testCanGetElementEnabled() {
        XCTAssertTrue(try! homeScreen.buttonsBtn().isEnabled())
    }

    func testCanGetElementDisplayed() {
        XCTAssertTrue(try! homeScreen.buttonsBtn().isDisplayed())
    }
}
