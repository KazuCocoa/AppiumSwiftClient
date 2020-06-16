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
        let response = """
            {"value":""}
        """.data(using: .utf8)!

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/context") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(response, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertNoThrow(try! driver.setContext(name: "NATIVE_APP").get())
    }

    func testSetContextNoSuchContextError() {
        let errorMessage = """
        {
          "value": {
            "error": "unknown error",
            "message": "No such context found.",
            "stacktrace": "NoSuchContextError: No such context found."
          }
        }
        """.data(using: .utf8)!

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/context") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(errorMessage, status: 400))

        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))

        XCTAssertThrowsError(try driver.setContext(name: "NATIVE").get()) { error in
            guard case WebDriverErrorEnum.unknownError(let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.message, "No such context found.")
        }
    }
}
