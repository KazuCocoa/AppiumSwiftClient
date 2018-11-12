//
//  CreateSession.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CCreateSession {
    static func sendRequest(with caps: AppiumCapabilities) -> String {
        let json = generateCapabilityBodyData(with: caps)

        // {"value":{"sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","capabilities":{"device":"iphone","browserName":"UICatalog","sdkVersion":"11.4","CFBundleIdentifier":"com.example.apple-samplecode.UICatalog"}},"sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","status":0}
        let value = HttpClient().sendSyncRequest(method: W3CCommands.newSession.0,
                                                 commandPath: W3CCommands.newSession.1,
                                                 json: json) as! [String: Any]
        let id = value["sessionId"] as! String
        return id
    }

    // TODO: implement test
    private static func generateCapabilityBodyData(with caps: AppiumCapabilities) -> Data {
        let invalidJson = "Not a valid JSON"

        let oSSdesiredCapability = OssDesiredCapability(with: caps)

        let w3cDesiredCapability = W3CDesiredCapability(with: caps)
        let w3cFirstMatch = W3CFirstMatch(firstMatch: [w3cDesiredCapability])

        let w3cCapability = W3CCapability(desiredCapabilities: oSSdesiredCapability, capabilities: w3cFirstMatch)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(w3cCapability)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    private struct W3CCapability : Codable {
        let desiredCapabilities : OssDesiredCapability
        let capabilities : W3CFirstMatch
    }

    private struct W3CFirstMatch : Codable {
        let firstMatch : [W3CDesiredCapability]
    }
}
