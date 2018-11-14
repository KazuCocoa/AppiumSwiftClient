//
//  CreateSession.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CCreateSession : CommandProtocol {
    func sendRequest(with caps: AppiumCapabilities) -> String {
        let json = generateCapabilityBodyData(with: caps)

        // {"value":{"sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","capabilities":{"device":"iphone","browserName":"UICatalog","sdkVersion":"11.4","CFBundleIdentifier":"com.example.apple-samplecode.UICatalog"}},"sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","status":0}
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.newSession.0,
                                                                     commandPath: commandUrl(),
                                                                     json: json)

        guard let value = returnValue["value"] as? [String: Any] else {
            return "no value"
        }

        if (statusCode == 200) {
            let id = value["sessionId"] as! String
            return id
        } else {
            print("Status code is \(statusCode)")
            return "error happensed"
        }
    }

    func commandUrl(with sessionId: Session.Id = "", and elementId: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands.newSession.1
    }

    // TODO: implement test
    private func generateCapabilityBodyData(with caps: AppiumCapabilities) -> Data {
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
