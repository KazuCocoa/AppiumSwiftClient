//
//  SendKeysTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 01.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation
import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class SendKeysTests: AppiumSwiftClientTestBase {

    let url = "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/element/test-element-id/value"

    func testSendKeys() {
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
        XCTAssertNoThrow(try element.sendKeys(with: "testKeys").get())
    }
    
    func testShouldFailWith400() {
        let errorMessage = """
        {
          "value": {
            "error": "invalid element state",
            "message": "Error Domain=com.facebook.WebDriverAgent Code=1",
            "stacktrace": "InvalidElementStateError: Error Domain=com.facebook.WebDriverAgent Code=1"
          }
        }
        """.data(using: .utf8)!
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == url) {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(errorMessage, status: 400))
        let element = MobileElement(id: "test-element-id", sessionId: "3CB9E12B-419C-49B1-855A-45322861F1F7")
        XCTAssertThrowsError(try element.sendKeys(with: "testKeys").get()) {
            error in guard case WebDriverErrorEnum.invalidElementStateError(error: let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual("invalid element state", error.error)
        }
    }
}
