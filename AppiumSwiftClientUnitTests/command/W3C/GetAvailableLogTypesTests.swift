//
//  W3CGetAvailableLogTypesTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 27.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class GetAvailableLogTypesTests: AppiumSwiftClientTestBase {
    
    func testCanGetAvailableLogTypesTest() {
        let body = """
            {
              "value": [
                "syslog",
                "crashlog",
                "performance",
                "server",
                "safariConsole",
                "safariNetwork"
              ]
            }
        """.data(using: .utf8)!
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/log/types") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }

        stub(matcher, jsonData(body, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        do {
            let logTypes = try driver.getAvailableLogTypes().get()
            XCTAssertFalse(logTypes.isEmpty)
            XCTAssertTrue(logTypes.contains("syslog"))
            XCTAssertTrue(logTypes.contains("crashlog"))
            XCTAssertTrue(logTypes.contains("performance"))
            XCTAssertTrue(logTypes.contains("server"))
            XCTAssertTrue(logTypes.contains("safariConsole"))
            XCTAssertTrue(logTypes.contains("safariNetwork"))
        } catch {
            XCTFail()
        }
    }
}
