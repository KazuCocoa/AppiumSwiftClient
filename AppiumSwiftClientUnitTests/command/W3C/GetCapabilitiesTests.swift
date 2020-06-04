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
        let response = """
            {
              "value": {
                "udid": "3CB9E12B-419C-49B1-855A-45322861F1F7",
                "platformName": "iOS",
                "app": "path/to/app",
                "platformVersion": "13.5",
                "deviceName": "iPhone 8",
                "device": "iphone",
                "browserName": "UICatalog",
                "sdkVersion": "13.5",
                "CFBundleIdentifier": "com.example.apple-samplecode.UICatalog",
                "pixelRatio": 2,
                "statBarHeight": 20,
                "viewportRect": {
                  "left": 0,
                  "top": 40,
                  "width": 640,
                  "height": 1096
                }
              }
            }
        """.data(using: .utf8)!

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(response, status: 200))

        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))

        let caps = try! driver.getCapabilities().get()
        XCTAssertEqual("3CB9E12B-419C-49B1-855A-45322861F1F7", caps.udid)
        XCTAssertEqual(["left": 0, "top":40, "width":640, "height":1096], caps.viewportRect?.asDictionary())
    }
}
