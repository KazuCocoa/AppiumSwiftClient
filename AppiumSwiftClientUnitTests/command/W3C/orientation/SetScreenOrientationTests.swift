//
//  SetScreenOrientationTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 11.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class SetScreenOrientationTest: AppiumSwiftClientTestBase {
    func testCanRotateToLandscape() {
        let body = [
            "value": ""
        ]
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/orientation") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, json(body, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertNoThrow(try driver.rotate(to: ScreenOrientationEnum.landscape).get())
    }
    
    func testCanRotateToPortrait() {
        let response = """
            {"value":""}
        """.data(using: .utf8)!
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/orientation") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, jsonData(response, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertNoThrow(try driver.rotate(to: ScreenOrientationEnum.portrait).get())
    }
    
    func testRotateDeviceFailsWith500() {
        let response = """
            {
              "value": {
                "error": "unknown error",
                "message": "An unknown server-side error occurred while processing the command. Original error: Unable To Rotate Device",
                "stacktrace": "UnknownError: An unknown server-side error occurred while processing the command. Original error: Unable To Rotate Device"
              }
            }
        """.data(using: .utf8)!
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/orientation") {
                XCTAssertEqual(HttpMethod.post.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        
        stub(matcher, jsonData(response, status: 500))
        let driver = try! AppiumDriver(AppiumCapabilities(super.iOSOpts))
        XCTAssertThrowsError(try driver.rotate(to: ScreenOrientationEnum.portrait).get()) {
            error in guard case WebDriverErrorEnum.unknownError(error: let error) = error else {
                return XCTFail()
            }
            XCTAssertEqual(error.error, "unknown error")
        }
    }
}
