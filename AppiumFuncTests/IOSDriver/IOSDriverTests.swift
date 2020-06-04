//
//  IOSDriverTests.swift
//  AppiumFuncTests
//
//  Created by Gabriel Fioretti on 20.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
@testable import AppiumSwiftClient

class IOSDriverTests: XCTestCase {
    var driver: IOSDriver!

    override func setUp() {
        let packageRootPath = URL(
            fileURLWithPath: #file.replacingOccurrences(of: "AppiumFuncTests/IOSDriver/IOSDriverTests.swift", with: "")
            ).path

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "\(packageRootPath)/AppiumFuncTests/app/UICatalog.app.zip",
            DesiredCapabilitiesEnum.platformVersion: "13.5",
            DesiredCapabilitiesEnum.deviceName: "iPhone 8",
            DesiredCapabilitiesEnum.reduceMotion: "true"
        ]
        do {
            driver = try IOSDriver(AppiumCapabilities(opts))
        } catch {
            XCTFail("Failed to spin up driver: \(error)")
        }
    }

    func testGetSettings() {
        do {
            let settings = try driver.getSettings().get()
            XCTAssertNotNil(settings)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testCanSetSetting() {
        do {
            let settings = try driver.getSettings().get()
            let mjpegServerFramerateBefore = settings.mjpegServerFramerate
            driver.setMjpegServerFramerate(to: 30)
            let settingsAfter = try driver.getSettings().get()
            let mjpegServerFramerateAfter = settingsAfter.mjpegServerFramerate
            XCTAssertNotEqual(mjpegServerFramerateBefore, mjpegServerFramerateAfter)
        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testCanGetSyslog() {
        do {
            let syslog = try driver.getSyslog().get()
            XCTAssertFalse(syslog.isEmpty)
        } catch {
            XCTFail("\(error)")
        }
    }

    override func tearDown() {
        do {
            try driver.quit().get()
        } catch {
            XCTFail("Failed to quit driver: \(error)")
        }
    }
}
