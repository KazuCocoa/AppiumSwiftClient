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
        let response = """
            {
              "value": {
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
                "reduceMotion": null
              }
            }
        """.data(using: .utf8)!
        
        func matcher(request: URLRequest) -> Bool {
            if (request.url?.absoluteString == "http://127.0.0.1:4723/wd/hub/session/3CB9E12B-419C-49B1-855A-45322861F1F7/appium/settings") {
                XCTAssertEqual(HttpMethod.get.rawValue, request.httpMethod)
                return true
            } else {
                return false
            }
        }
        stub(matcher, jsonData(response, status: 200))
        let driver = try! IOSDriver(AppiumCapabilities(super.iOSOpts))
        do {
            let settings = try driver.getSettings().get()
            XCTAssertNotNil(settings)
            XCTAssertTrue(settings.imageMatchThreshold == 0.4)
            XCTAssertTrue(settings.fixImageFindScreenshotDims == true)
            XCTAssertTrue(settings.fixImageTemplateSize == false)
            XCTAssertTrue(settings.fixImageTemplateScale == false)
            XCTAssertTrue(settings.defaultImageTemplateScale == 1)
            XCTAssertTrue(settings.checkForImageElementStaleness == true)
            XCTAssertTrue(settings.autoUpdateImageElementPosition == false)
            XCTAssertTrue(settings.imageElementTapStrategy == "w3cActions")
            XCTAssertTrue(settings.getMatchedImageResult == false)
            XCTAssertTrue(settings.nativeWebTap == false)
            XCTAssertTrue(settings.nativeWebTapStrict == false)
            XCTAssertTrue(settings.useJSONSource == false)
            XCTAssertTrue(settings.shouldUseCompactResponses == true)
            XCTAssertTrue(settings.elementResponseAttributes == "type,label")
            XCTAssertTrue(settings.mjpegServerScreenshotQuality == 25)
            XCTAssertTrue(settings.mjpegServerFramerate == 10)
            XCTAssertTrue(settings.screenshotQuality == 1)
            XCTAssertTrue(settings.mjpegScalingFactor == 100)
            XCTAssertTrue(settings.reduceMotion == nil)
        } catch {
            XCTFail()
        }
    }
}
