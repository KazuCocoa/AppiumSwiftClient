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
    func testImplicitTimout() {
        let body = [
            "value": ""
        ]
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/timeouts") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, json(body, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        XCTAssertEqual(try driver.setImplicitTimeout(timeoutInMillisencods: 300), "")
    }
    
    func testPageLoadTimeout() {
        let body = [
            "value": ""
        ]
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/timeouts") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, json(body, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        XCTAssertEqual(try driver.setPageLoadTimeout(timeoutInMillisencods: 300), "")
    }

    func testScriptTimeout() {
        let body = [
            "value": ""
        ]
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/timeouts") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, json(body, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        XCTAssertEqual(try driver.setScriptTimeout(timeoutInMillisencods: 300), "")
    }
    
    func testTimeoutBadParameterError() {
        let error = [
            "value": [
                "error": "invalid argument",
                "message": "Parameters were incorrect.",
                "stacktrace": "BadParametersError: Parameters were incorrect."
            ]
        ]
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/timeouts") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, json(error, status: 404))
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        XCTAssertThrowsError(try driver.setImplicitTimeout(timeoutInMillisencods: 300)) {
            error in guard case WebDriverErrorEnum.invalidArgumentError(error: let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.error, "invalid argument")
        }
    }
}
