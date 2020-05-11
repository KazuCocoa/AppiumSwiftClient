//
//  GetScreenOrientation.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 11.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class GetScreenOrientationTests: AppiumSwiftClientTestBase {
    func testGestScreenOrientation() {
        let body = [
            "value": "PORTRAIT",
            "sessionId": "3CB9E12B-419C-49B1-855A-45322861F1F7"
        ]
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/orientation") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, json(body, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        XCTAssertEqual(try driver.getScreenOrientation(), "PORTRAIT")
    }
}
