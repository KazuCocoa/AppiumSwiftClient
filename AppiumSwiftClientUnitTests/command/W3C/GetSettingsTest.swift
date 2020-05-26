//
//  GetSettingsTest.swift
//  AppiumSwiftClientUnitTests
//
//  Created by Gabriel Fioretti on 19.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation
import XCTest
import Mockingjay

@testable import AppiumSwiftClient

class GetSettingsTest: AppiumSwiftClientTestBase {
    
    func testGetIOSSettings() {
        let body = [
          "value": [
            "imageMatchThreshold": 0.4,
            "fixImageFindScreenshotDims": true,
            "fixImageTemplateSize": false,
            "fixImageTemplateScale": false,
            "defaultImageTemplateScale": 1,
            "checkForImageElementStaleness": true,
            "autoUpdateImageElementPosition": false,
            "imageElementTapStrategy": "w3cActions",
            "getMatchedImageResult": false,
            "nativeWebTap": false,
            "nativeWebTapStrict": false,
            "useJSONSource": false,
            "shouldUseCompactResponses": true,
            "elementResponseAttributes": "type,label",
            "mjpegServerScreenshotQuality": 25,
            "mjpegServerFramerate": 10,
            "screenshotQuality": 1,
            "mjpegScalingFactor": 100,
            "reduceMotion": 1
          ]
        ]
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/appium/settings") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, json(body, status: 200))
        let driver = try! AppiumDriver(AppiumCapabilities(super.opts))
        do {
            let settings = try driver.getSettings()
            XCTAssertEqual(settings["imageMatchThreshold"] as! Double, 0.4)
            XCTAssertEqual(settings["fixImageFindScreenshotDims"] as! Bool, true)
            XCTAssertEqual(settings["fixImageTemplateSize"] as! Bool, false)
            XCTAssertEqual(settings["fixImageTemplateScale"] as! Bool, false)
            XCTAssertEqual(settings["defaultImageTemplateScale"] as! Int, 1)
            XCTAssertEqual(settings["checkForImageElementStaleness"] as! Bool, true)
            XCTAssertEqual(settings["autoUpdateImageElementPosition"] as! Bool, false)
            XCTAssertEqual(settings["imageElementTapStrategy"] as! String, "w3cActions")
            XCTAssertEqual(settings["getMatchedImageResult"] as! Bool, false)
            XCTAssertEqual(settings["nativeWebTap"] as! Bool, false)
            XCTAssertEqual(settings["nativeWebTapStrict"] as! Bool, false)
            XCTAssertEqual(settings["useJSONSource"] as! Bool, false)
            XCTAssertEqual(settings["shouldUseCompactResponses"] as! Bool, true)
            XCTAssertEqual(settings["elementResponseAttributes"] as! String, "type,label")
            XCTAssertEqual(settings["mjpegServerScreenshotQuality"] as! Int, 25)
            XCTAssertEqual(settings["mjpegServerFramerate"] as! Int, 10)
            XCTAssertEqual(settings["screenshotQuality"] as! Int, 1)
            XCTAssertEqual(settings["mjpegScalingFactor"] as! Int, 100)
            XCTAssertEqual(settings["reduceMotion"] as! Int, 1)
        } catch {
            XCTFail()
        }
    }
}
