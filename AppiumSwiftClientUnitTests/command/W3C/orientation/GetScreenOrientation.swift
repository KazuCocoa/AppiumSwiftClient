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
        let response = """
            {
              "value": "PORTRAIT",
              "sessionId": "54934a99-e8e6-4cf9-b24d-7046161068ef"
            }
        """.data(using: .utf8)!
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/orientation") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, jsonData(response, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertEqual(try driver.getScreenOrientation().get(), "PORTRAIT")
    }
}
