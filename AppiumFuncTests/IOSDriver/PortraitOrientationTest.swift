//
//  CanRotateToPortraitTest.swift
//  AppiumFuncTests
//
//  Created by Gabriel Fioretti on 11.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
@testable import AppiumSwiftClient

class PortraitOrientationTest: FunctionalBaseTest {

    override func setUp() {
        desiredCapabilities = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "com.apple.mobileslideshow",
            DesiredCapabilitiesEnum.platformVersion: "13.5",
            DesiredCapabilitiesEnum.deviceName: "iPhone 8",
            DesiredCapabilitiesEnum.reduceMotion: "true",
            DesiredCapabilitiesEnum.orientation: ScreenOrientationEnum.landscape.rawValue
        ]
        super.setUp()
    }

    func testCanLaunchAppInLandscapeMode() {
        do {
            XCTAssertTrue(try driver.getScreenOrientation().get() == ScreenOrientationEnum.landscape.rawValue)
        }
    }

    func testCanRotateToPortrait() {
        do {
            let orientationBefore = try driver.getScreenOrientation().get()
            driver.rotate(to: ScreenOrientationEnum.portrait)
            let orientationAfter = try driver.getScreenOrientation().get()
            XCTAssertTrue(orientationBefore != orientationAfter)
            XCTAssertTrue(orientationAfter == ScreenOrientationEnum.portrait.rawValue)
        } catch let error {
            XCTFail("\(error)")
        }
    }
}
