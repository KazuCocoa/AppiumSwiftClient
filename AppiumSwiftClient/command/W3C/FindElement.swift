//
//  FindElement.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CFindElement {
    private let noElement = "no element"

    static func sendRequest(by locator: SearchContext, with value: String, to sessionId: Session.Id) -> Element {
        let findElement = self.init()

        let json = findElement.generateFindElementBodyData(by: locator, with: value)

        let urlBase = W3CCommands.findElement.1
        let commandPath = urlBase.replacingOccurrences(of: ":sessionId", with: sessionId)

        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.findElement.0,
                                                               commandPath: commandPath,
                                                               json: json) as! (Int, [String: Any])

        guard let value = returnValue["value"] as? [String: String] else {
            return Element(id: findElement.noElement, sessionId: sessionId)
        }

        if (statusCode == 200) {
            return Element(id: findElement.elementIdFrom(param: value), sessionId: sessionId)
        } else {
            print("Status code is \(statusCode)")
            return Element(id: findElement.noElement, sessionId: sessionId)
        }
    }

    private func generateFindElementBodyData(by locator: SearchContext, with value: String) -> Data {
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

    private func elementIdFrom(param: [String: String]) -> String {
        return param["ELEMENT"] ?? param["element-6066-11e4-a52e-4f735466cecf"] ?? noElement
    }

    private struct W3CFindElementParam : Codable {
        let using : String
        let value : String
    }
}
