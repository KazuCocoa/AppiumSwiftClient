//
//  CreateSessionTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/11/19.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class CreateSessionTests: XCTestCase {
    let response = """
        {
          "value": {
            "capabilities": {
              "webStorageEnabled": false,
              "locationContextEnabled": false,
              "browserName": "",
              "platform": "MAC",
              "javascriptEnabled": true,
              "databaseEnabled": false,
              "takesScreenshot": true,
              "networkConnectionEnabled": false,
              "platformName": "iOS",
              "reduceMotion": true,
              "automationName": "xcuitest",
              "app": "path/to/app",
              "platformVersion": "13.5",
              "deviceName": "iPhone 8",
              "udid": "3CB9E12B-419C-49B1-855A-45322861F1F7"
            },
            "sessionId": "3CB9E12B-419C-49B1-855A-45322861F1F7"
          }
        }
    """.data(using: .utf8)!

    override func setUp() {
        super.setUp()
        mockingjayRemoveStubOnTearDown = true
    }

    func testCreateSession() {
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(response, status: 200))

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/app",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone 8",
            DesiredCapabilitiesEnum.reduceMotion: "true"
        ]

        let driver = try! AppiumDriver(AppiumCapabilities(opts))
        XCTAssertEqual(driver.currentSession.id, "3CB9E12B-419C-49B1-855A-45322861F1F7")
    }

    func testCreateSessionWith500Error() {
        let errorMessage = """
            {
              "value": {
                "error": "session not created",
                "message": "error messages",
                "stacktrace": "dummy stack trace"
              }
            }
        """.data(using: .utf8)!

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(errorMessage, status: 500))

        let opts = [
            DesiredCapabilitiesEnum.platformName: "iOS",
            DesiredCapabilitiesEnum.automationName: "xcuitest",
            DesiredCapabilitiesEnum.app: "path/to/app",
            DesiredCapabilitiesEnum.platformVersion: "11.4",
            DesiredCapabilitiesEnum.deviceName: "iPhone 8",
            DesiredCapabilitiesEnum.reduceMotion: "true"
        ]

        XCTAssertThrowsError(try AppiumDriver(AppiumCapabilities(opts))) { error in
            guard case WebDriverErrorEnum.sessionNotCreatedError(let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.error, "session not created")
        }
    }
}
