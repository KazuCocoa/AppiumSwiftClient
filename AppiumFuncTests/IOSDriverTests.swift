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
            fileURLWithPath: #file.replacingOccurrences(of: "AppiumFuncTests/IOSDriverTests.swift", with: "")
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

    func testCanSetSetting() {
        do {
            let settings = try driver.getSettings()
            let mjpegServerFramerateBefore = settings["mjpegServerFramerate"] as! Int // swiftlint:disable:this force_cast
            try driver.setMjpegServerFramerate(to: 30)
            let settingsAfter = try driver.getSettings()
            let mjpegServerFramerateAfter = settingsAfter["mjpegServerFramerate"] as! Int // swiftlint:disable:this force_cast
            XCTAssertNotEqual(mjpegServerFramerateBefore, mjpegServerFramerateAfter)
        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testCanGetSyslog() {
        do {
            let syslog = try driver.getSyslog()
            XCTAssertFalse(syslog.isEmpty)
        } catch {
            XCTFail("\(error)")
        }
    }

    override func tearDown() {
        driver.quit()
    }
}
