//
//  ElementLocationTests.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 20.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation
import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class ElementLocationTests: AppiumSwiftClientTestBase {

    let url = "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/element/test-element-id/location"
    
    func testElementLocationCoodinates() {
        let response = """
        {
          "value": {
            "y": 68,
            "x": 15
          }
        }
        """.data(using: .utf8)!

        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == url) {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(response, status: 200))

        let element = MobileElement(id: "test-element-id", sessionId: "3CB9E12B-419C-49B1-855A-45322861F1F7")
        let elementPoint = try! element.getElementLocation()
        XCTAssertTrue(elementPoint.xCoord == 15)
        XCTAssertTrue(elementPoint.yCoord == 68)
    }
}
