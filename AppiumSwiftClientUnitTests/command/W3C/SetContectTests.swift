//
//  SetContect.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/12/31.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//


import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class SetContextTests: AppiumSwiftClientTestBase {

    func testSetContext() {
        let body = [
            "value": ""
        ]

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/context") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(body, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        XCTAssertEqual(try driver.setContext(name: "NATIVE_APP"), "")
    }

    func testSetContextNoSuchContextError() {
        let errorMessage = [
            "value": [
                "error": "no such context",
                "message": "No such context found.",
                "stacktrace": "Encountered internal error running command: NoSuchContextError: No such context found."
            ]
        ]

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/context") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(errorMessage, status: 400))

        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))

        XCTAssertThrowsError(try driver.setContext(name: "NATIVE")) { error in
            guard case WebDriverErrorEnum.noSuchContextError(let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.error, "no such context")
        }
    }
}
