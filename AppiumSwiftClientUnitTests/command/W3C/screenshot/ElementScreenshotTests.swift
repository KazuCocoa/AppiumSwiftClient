//
//  ElementScreenshotTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2019/01/02.
//  Copyright © 2019 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class ElementScreenshotTests: AppiumSwiftClientTestBase {

    func testElementScreenshot() {
        let base64 = "iVBORw0KGgoAAAANSUhEUgAAAu4AAAU2CAIAAABFtaRRAAAAAXNSR0IArs4c6QAA\r\nABxpRE9UAAAAAgAAAAAAAAKbAAAAKAAAApsAAAKb"
        let body = [ "value": base64 ]

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/element/test-element-id/screenshot") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(body, status: 200))

        let element = Element(id: "test-element-id", sessionId: "3CB9E12B-419C-49B1-855A-45322861F1F7")

        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        XCTAssertEqual(driver.getBase64Screenshot(with: element), base64)
    }
}
