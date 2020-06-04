//
//  GeLogTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 29.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class GetLogTests: AppiumSwiftClientTestBase {
    
    func testCanGetSyslogTest() {
        let response = """
        {
          "value": [
            {
              "timestamp": 1590746803861,
              "level": "ALL",
              "message": "2020-05-29 12:06:43.858 Df runningboardd[2308:ee9f] [com.apple.runningboard:power] Attempting to rename power assertion 34565 for target application<com.facebook.WebDriverAgentRunner.xctrunner> to application<com.facebook.WebDriverAgentRunner.xctrunner>2308-2440-37:Developer testing(BackgroundUI)"
            },
            {
              "timestamp": 1590746803958,
              "level": "ALL",
              "message": "2020-05-29 12:06:43.957 Df DTServiceHub[2457:e8ca] [com.apple.dt.instruments:heartbeat] Heartbeat"
            }
          ]
        }
        """.data(using: .utf8)!

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/log") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }

        /*
         Use jsonData instead of json
         */
        stub(matcher, jsonData(response, status: 200))
        let driver = try! IOSDriver(AppiumCapabilities(super.iOSOpts))
        do {
            let syslog = try driver.getSyslog().get()
            XCTAssertTrue(syslog.count == 2)
        } catch {
            XCTFail()
        }
    }
    
    func testGetSyslogFailsWith404() {
        let response = """
            {
              "value": {
                "error": "invalid session id",
                "message": "A session is either terminated or not started",
                "stacktrace": "NoSuchDriverError: A session is either terminated or not started\\n    at asyncHandler (/usr/local/lib/node_modules/appium/node_modules/appium-base-driver/lib/protocol/protocol.js:255:15)"
              }
            }
        """.data(using: .utf8)!
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/log") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }

        stub(matcher, jsonData(response, status: 404))
        let driver = try! IOSDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertThrowsError(try driver.getSyslog().get()) {
            error in guard case WebDriverErrorEnum.invalidSessionIdError(error: let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.error, "invalid session id")
        }
    }
}
