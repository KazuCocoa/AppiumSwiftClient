//
//  ScreenOrientationTests.swift
//  AppiumFuncTests
//
//  Created by Gabriel Fioretti on 11.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
@testable import AppiumSwiftClient

class LandscapeOrientationTest: FunctionalBaseTest {

    override func setUp() {
        desiredCapabilities = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "com.apple.mobileslideshow",
            DesiredCapabilitiesEnum.platformVersion: "13.5",
            DesiredCapabilitiesEnum.deviceName: "iPhone 8",
            DesiredCapabilitiesEnum.reduceMotion: "true"
        ]
        super.setUp()
    }

    func testAppLaunchInPortraitModeDefault() {
        do {
            XCTAssertTrue(try driver.getScreenOrientation().get() == ScreenOrientationEnum.portrait.rawValue)
        }
    }

    func testCanRotateScreenToLandscape() {
        do {
            let orientationBefore = try driver.getScreenOrientation().get()
            driver.rotate(to: ScreenOrientationEnum.landscape)
            let orientationAfter = try driver.getScreenOrientation().get()
            XCTAssertTrue(orientationBefore != orientationAfter)
            XCTAssertTrue(orientationAfter == ScreenOrientationEnum.landscape.rawValue)
        } catch let error {
            XCTFail("\(error)")
        }
    }
}
