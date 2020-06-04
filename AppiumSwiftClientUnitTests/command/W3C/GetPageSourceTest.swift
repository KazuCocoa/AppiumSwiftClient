//
//  GetPageSourceTest.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 04.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class GetPageSourceTest: AppiumSwiftClientTestBase {
    func testCanGetPageSource() {
        let value = "<AppiumAUT></AppiumAUT>"
        let response = """
            {"value":"\(value)"}
        """.data(using: .utf8)!
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/source") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(response, status: 200))
        
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertEqual(try driver.getPageSource().get(), value)
    }
    
    func testCantGetPageSource() {
        let errorMessage = """
        {
          "value": {
            "error": "invalid session id",
            "message": "A session is either terminated or not started",
            "stacktrace": "NoSuchDriverError: A session is either terminated or not started"
          }
        }
        """.data(using: .utf8)!
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/source") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(errorMessage, status: 404))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        
        XCTAssertThrowsError(try driver.getPageSource().get()) {
            error in guard case WebDriverErrorEnum.invalidSessionIdError(error: let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.error, "invalid session id")
        }
    }
}
