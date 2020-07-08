//
//  ClearTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 04.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class ClearTest: AppiumSwiftClientTestBase {
    
    let url = "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/element/test-element-id/clear"
    
    func testClearElement() {
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

        let element = MobileElement(id: "test-element-id", sessionId: "3CB9E12B-419C-49B1-855A-45322861F1F7")
        XCTAssertNoThrow(try element.clear().get())
    }
}
