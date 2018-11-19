//
//  GetCapabilitiesTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/11/19.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class GetCapabilitiesTests: AppiumSwiftClientTestBase {
    func testGetCapabilities() {
        let body = [
            "value": [
                "udid": "3CB9E12B-419C-49B1-855A-45322861F1F7",
                "platformName": "iOS",
                "reduceMotion":true,
                "automationName":"xcuitest",
                "deviceName":"iPhone 8",
                "platformVersion":"11.4",
                "app":"path/to/app",
                "device":"iphone",
                "browserName":"UICatalog",
                "sdkVersion":"11.4",
                "CFBundleIdentifier":"com.example.apple-samplecode.UICatalog",
                "pixelRatio":2,
                "statBarHeight":23.4375,
                "viewportRect": [
                    "left": 0,
                    "top":47,
                    "width":750,
                    "height":1287
                ]
            ]
        ]

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(body, status: 200))

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/test",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone Simulator",
            ]
        let driver = try! AppiumDriver(AppiumCapabilities(opts))

        let caps = driver.getCapabilities()
        XCTAssertEqual("3CB9E12B-419C-49B1-855A-45322861F1F7", caps["udid"] as! String)
        XCTAssertEqual(["left": 0, "top":47, "width":750, "height":1287], caps["viewportRect"] as! [String : Int])
    }
}
