//
//  CreateSession.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

// TODO: Error handling for below case.
//Test Suite 'DriverTest' started at 2018-11-19 00:25:09.214
//Test Case '-[AppiumSwiftClientUnitTests.DriverTest testCreateSession]' started.
//2018-11-19 00:25:09.424581+0900 xctest[3011:64950] TIC TCP Conn Failed [1:0x7f84f480e030]: 1:61 Err(61)
//2018-11-19 00:25:09.436805+0900 xctest[3011:64950] Task <70F6243C-2CEE-41A8-9F5F-1A009005A6FC>.
// <1> HTTP load failed (error code: -1004 [1:61])
//2018-11-19 00:25:09.437206+0900 xctest[3011:64436] Task <70F6243C-2CEE-41A8-9F5F-1A009005A6FC>.
// <1> finished with error - code: -1004
//Error calling POST on http://127.0.0.1:4723/wd/hub/session
struct W3CCreateSession: CommandProtocol {
    func sendRequest(with caps: AppiumCapabilities) throws -> String {
        let json = generateBodyData(with: caps)

        // {"value":{"sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","capabilities":
        //  {"device":"iphone","browserName":"UICatalog","sdkVersion":"11.4",
        //    "CFBundleIdentifier":"com.example.apple-samplecode.UICatalog"}},
        //    "sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","status":0}
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.newSession.0,
                                                                     commandPath: commandUrl(),
                                                                     json: json)

        guard let value = returnValue["value"] as? [String: Any] else {
            return ""
        }

        if statusCode == 200 {
            let sessionId = value["sessionId"] as! String // swiftlint:disable:this force_cast
            return sessionId
        } else if statusCode == 500 {
            // swiftlint:disable force_cast
            let webDriverError = WebDriverError(errorResult: value as! [String: String])
            try webDriverError.raise()
            return "error happensed"
        } else {
            print("Status code is \(statusCode)")
            return "error happensed"
        }
    }

    func commandUrl(with sessionId: Session.Id = "", and elementId: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands.newSession.1
    }

    func generateBodyData(with caps: AppiumCapabilities) -> Data {
        let invalidJson = "Not a valid JSON"

        let oSSdesiredCapability = OssDesiredCapability(with: caps)

        let w3cDesiredCapability = W3CDesiredCapability(with: caps)
        let w3cFirstMatch = W3CFirstMatch(firstMatch: [w3cDesiredCapability])

        let w3cCapability = CommandParam(desiredCapabilities: oSSdesiredCapability, capabilities: w3cFirstMatch)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(w3cCapability)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let desiredCapabilities: OssDesiredCapability
        let capabilities: W3CFirstMatch
    }

    fileprivate struct W3CFirstMatch: CommandParamProtocol {
        let firstMatch: [W3CDesiredCapability]
    }
}
