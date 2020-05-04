//
//  EndSessionTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 01.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class EndSessionTests: AppiumSwiftClientTestBase {
    func testCanDeleteSession() {
        let body = [
            "value": ""
        ]
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7") {
                XCTAssertEqual(HttpMethod.delete.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(body, status: 200))
        
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        XCTAssertEqual(driver.quit(), "")
    }
}
