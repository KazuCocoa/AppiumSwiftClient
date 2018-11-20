//
//  FindElementTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/11/20.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class FindElementTests: AppiumSwiftClientTestBase {
    func testFindElement() {
        let body = [
            "value": [
                "element-6066-11e4-a52e-4f735466cecf": "test-element-id",
            ]
        ]

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/element") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(body, status: 200))

        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))

        let element = try! driver.findElement(by: .accessibilityId, with: "name")
        XCTAssertEqual(element.sessionId, "3CB9E12B-419C-49B1-855A-45322861F1F7")
        XCTAssertEqual(element.id, "test-element-id")
    }

    func testFindElementNoSuchElementError() {
        let errorMessage = [
            "value": [
                "error": "no such element",
                "message": "error messages",
                "stacktrace": "dummy stack trace"
            ]
        ]

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/element") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(errorMessage, status: 404))

        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))

        XCTAssertThrowsError(try driver.findElement(by: .accessibilityId, with: "name")) { error in
            guard case WebDriverErrorEnum.noSuchElementError(let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error["error"], "no such element")
        }
    }
}
