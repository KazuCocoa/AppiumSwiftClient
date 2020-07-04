//
//  CapabilitiesTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
import AppiumSwiftClient

class CapabilitiesTest : XCTestCase {
    func testDefineCapabilities() {
        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/test",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone Simulator",
        ]
        let caps = AppiumCapabilities(opts)
        XCTAssertEqual("iOS", caps.capabilities()[.platformName])
    }
}
