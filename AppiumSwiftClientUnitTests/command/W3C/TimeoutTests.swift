//
//  TimeoutTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 07.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class TimeoutTest: AppiumSwiftClientTestBase {
    
    let response = """
        {"value":""}
    """.data(using: .utf8)!
    
    func testImplicitTimout() {
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/timeouts") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, jsonData(response, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertNoThrow(try driver.setImplicitTimeout(timeoutInMillisencods: 300).get())
    }
    
    func testPageLoadTimeout() {
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/timeouts") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, jsonData(response, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertNoThrow(try driver.setPageLoadTimeout(timeoutInMillisencods: 300).get())
    }

    func testScriptTimeout() {
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/timeouts") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, jsonData(response, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertNoThrow(try driver.setScriptTimeout(timeoutInMillisencods: 300).get())
    }
    
    func testTimeoutBadParameterError() {
        let errorMessage = """
        {
          "value": {
            "error": "invalid argument",
            "message": "Parameters were incorrect.",
            "stacktrace": "BadParametersError: Parameters were incorrect."
          }
        }
        """.data(using: .utf8)!
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/timeouts") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, jsonData(errorMessage, status: 404))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertThrowsError(try driver.setImplicitTimeout(timeoutInMillisencods: 300).get()) {
            error in guard case WebDriverErrorEnum.invalidArgumentError(error: let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.error, "invalid argument")
        }
    }
}
