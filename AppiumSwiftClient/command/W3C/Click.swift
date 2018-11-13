//
//  Click.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CElementClick {
    private let noElement = "no element"

    static func sendRequest(_ elementId: Element.Id, with sessionId: Session.Id) -> String {
        let elementClick = self.init()

        let json = elementClick.generateElementClickBodyData()

        let urlBase = W3CCommands.elementClick.1
        let commandSessionPath = urlBase.replacingOccurrences(of: ":sessionId", with: sessionId)
        let commandsessionElementPath = commandSessionPath.replacingOccurrences(of: ":id", with: elementId)

        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.elementClick.0,
                                                               commandPath: commandsessionElementPath,
                                                               json: json) as! (Int, [String: Any])

        if (statusCode == 200) {
            return returnValue["value"] as! String
        } else {
            print("Status code is \(statusCode)")
            return returnValue["value"] as! String
        }
    }

    private func generateElementClickBodyData() -> Data {
        let invalidJson = "invalid JSON"

        let elementClickParam = W3CElementClickParam()

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(elementClickParam)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    private struct W3CElementClickParam : Codable {
    }
}
