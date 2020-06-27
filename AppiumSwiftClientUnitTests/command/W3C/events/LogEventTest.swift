//
//  LogEventTest.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 19.06.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class LogEventTest: AppiumSwiftClientTestBase {
    
    private var url = "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/appium/log_event"
    
    func testCanLogCustomEvent() {
        let response = """
            {"value":""}
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
        XCTAssertNoThrow(try driver.logEvent(with: "funEvent", and: "appium").get())
    }
}
