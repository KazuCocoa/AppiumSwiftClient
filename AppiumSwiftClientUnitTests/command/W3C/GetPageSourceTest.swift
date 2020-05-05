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
        let body = [
            "value": "<?xml version=\"1.0\" encoding=\"UTF-8\"?><AppiumAUT></AppiumAUT>"
        ]
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/source") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(body, status: 200))
        
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        XCTAssertEqual(try driver.getPageSource(), "<?xml version=\"1.0\" encoding=\"UTF-8\"?><AppiumAUT></AppiumAUT>")
    }
    
    func testCantGetPageSource() {
        let error = [
            "value": [
                "error": "invalid session id",
                "message": "A session is either terminated or not started",
                "stacktrace": "NoSuchDriverError: A session is either terminated or not started"
            ]
        ]
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/source") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(error, status: 404))
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        
        XCTAssertThrowsError(try driver.getPageSource()) {
            error in guard case WebDriverErrorEnum.invalidSessionIdError(error: let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.error, "invalid session id")
        }
    }
}
