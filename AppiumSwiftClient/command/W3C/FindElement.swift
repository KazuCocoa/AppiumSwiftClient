//
//  FindElement.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CFindElement {
    static func sendRequest(by locator: SearchContext, with value: String, to sessionId: Session.Id) -> Element {
        let json = generateFindElementBodyData(by: locator, with: value)

        let urlBase = W3CCommands.findElement.1
        let commandPath = urlBase.replacingOccurrences(of: ":sessionId", with: sessionId)

        // {"value":{"sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","capabilities":{"device":"iphone","browserName":"UICatalog","sdkVersion":"11.4","CFBundleIdentifier":"com.example.apple-samplecode.UICatalog"}},"sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","status":0}
        let (statusCode, value) = HttpClient().sendSyncRequest(method: W3CCommands.findElement.0,
                                                               commandPath: commandPath,
                                                               json: json) as! (Int, [String: String])

        if (statusCode == 200) {
            return Element(id: elementIdFrom(param: value))
        } else {
            print("Status code is \(statusCode)")
            return Element(id: sessionId)
        }
    }

    private static func generateFindElementBodyData(by locator: SearchContext, with value: String) -> Data {
        let invalidJson = "Not a valid JSON"

        let findElementParam = W3CFindElementParam(using: locator.rawValue, value: value)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(findElementParam)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    private static func elementIdFrom(param: [String: String]) -> String {
        return param["ELEMENT"] ?? param["element-6066-11e4-a52e-4f735466cecf"] ?? "no element"
    }

    private struct W3CFindElementParam : Codable {
        let using : String
        let value : String
    }
}
