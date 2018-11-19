//
//  AppiumSwiftClientTestBase.swift
//  AppiumSwiftClientUnitTests
//
//  Created by kazuaki matsuo on 2018/11/19.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import XCTest
import Mockingjay

class AppiumSwiftClientTestBase : XCTestCase {
    func stubCreateSession() {
        let body = [
            "value": [
                "capabilities": [
                    "webStorageEnabled": false,
                    "locationContextEnabled": false,
                    "browserName":"",
                    "platform":"MAC",
                    "javascriptEnabled":true,
                    "databaseEnabled":false,
                    "takesScreenshot":true,
                    "networkConnectionEnabled":false,
                    "platformName":"iOS",
                    "reduceMotion":true,
                    "automationName":"xcuitest",
                    "deviceName":"iPhone 8",
                    "platformVersion":"11.4",
                    "app": "path/to/app",
                    "udid": "3CB9E12B-419C-49B1-855A-45322861F1F7"
                ],
                "sessionId":"3CB9E12B-419C-49B1-855A-45322861F1F7",
                "status": 0
            ]
        ]

        func matcher(request: URLRequest) -> Bool {
            if (request.httpMethod == "POST" && request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session") {
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(body, status: 200))
    }

    override func setUp() {
        stubCreateSession()
    }
}
