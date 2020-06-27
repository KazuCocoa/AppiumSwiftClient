//
//  GetPageSourceTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 21.06.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation
import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class GetEventsTests: AppiumSwiftClientTestBase {
    
    private var url = "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/appium/events"
    
    func testGetEventsTest() {
        let response = """
            {
              "value": {
                "commands": [
                  {
                    "cmd": "logCustomEvent",
                    "startTime": 1592746926635,
                    "endTime": 1592746926635
                  },
                  {
                    "cmd": "logCustomEvent",
                    "startTime": 1592746929285,
                    "endTime": 1592746929285
                  },
                  {
                    "cmd": "logCustomEvent",
                    "startTime": 1592746931355,
                    "endTime": 1592746931356
                  },
                  {
                    "cmd": "getLogEvents",
                    "startTime": 1592746944221,
                    "endTime": 1592746944221
                  }
                ],
                "xcodeDetailsRetrieved": [
                  1592746904176
                ],
                "appConfigured": [
                  1592746904176
                ],
                "resetStarted": [
                  1592746904176
                ],
                "resetComplete": [
                  1592746904176
                ],
                "logCaptureStarted": [
                  1592746904608
                ],
                "simStarted": [
                  1592746904837
                ],
                "wdaStartAttempted": [
                  1592746904963
                ],
                "wdaSessionAttempted": [
                  1592746904967
                ],
                "wdaSessionStarted": [
                  1592746905014
                ],
                "wdaStarted": [
                  1592746905015
                ],
                "orientationSet": [
                  1592746905015
                ],
                "appium:funEven": [
                  1592746926635,
                  1592746929285,
                  1592746931355
                ]
              }
            }
        """.data(using: .utf8)!
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == url) {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(response, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        let events = try? driver.getEvents()
        XCTAssert(events?.commands.count == 4)
        XCTAssert(events?.events.count == 12)
        XCTAssert(events?.events["appium:funEven"]?.count == 3)
    }
    
    func testGetEventsTest2() {
        let response = """
            {
              "value": {
                "error": "invalid session id",
                "message": "A session is either terminated or not started",
                "stacktrace": "NoSuchDriverError: A session is either terminated or not started"
              }
            }
        """.data(using: .utf8)!
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == url) {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(response, status: 500))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertThrowsError(try driver.getEvents()) {
            error in guard case WebDriverErrorEnum.invalidSessionIdError(error: let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.error, "invalid session id")
        }
    }
}
