//
//  FindElementsTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/11/20.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class FindElementsTests: AppiumSwiftClientTestBase {

    func testFindElements() {
        let body = [
            "value": [
                ["element-6066-11e4-a52e-4f735466cecf": "test-element-id1"],
                ["element-6066-11e4-a52e-4f735466cecf": "test-element-id2"]
            ]
        ]

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/elements") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(body, status: 200))

        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))

        let elements = try! driver.findElements(by: .accessibilityId, with: "name")
        XCTAssertEqual(elements.first?.sessionId, "3CB9E12B-419C-49B1-855A-45322861F1F7")
        XCTAssertEqual(elements.first?.id, "test-element-id1")
        XCTAssertEqual(elements.count, 2)
    }

    func testFindElementsNoSuchElementError() {
        let errorMessage = [
            "value": []
        ]

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/elements") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(errorMessage, status: 404))

        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))

        let elements = try! driver.findElements(by: .accessibilityId, with: "name")
        XCTAssertEqual(elements.count, 0)
    }
}
