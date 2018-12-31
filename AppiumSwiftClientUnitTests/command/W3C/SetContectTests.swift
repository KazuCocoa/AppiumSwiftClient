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

    func testAvailableCOntexts() {
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
        XCTAssertNotNil(driver.setContext(name: "NATIVE"))
    }
}
