//
//  Click.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CElementClick : CommandProtocol {
    private let noElement = "no element"

    func sendRequest(_ elementId: Element.Id, with sessionId: Session.Id) -> String {
        let json = generateElementClickBodyData()
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.elementClick.0,
                                                                     commandPath: commandUrl(with: sessionId, and: elementId),
                                                                     json: json)

        if (statusCode == 200) {
            return returnValue["value"] as! String
        } else if (statusCode == 400) {
            print("invalid parameter")
            print(returnValue)
            return noElement
        } else {
            print("Status code is \(statusCode)")
            print(returnValue)
            return noElement
        }
    }

    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id) -> W3CCommands.CommandPath {
        let urlBase = W3CCommands.elementClick.1
        return urlBase
            .replacingOccurrences(of: W3CCommands.Id.Session.rawValue, with: sessionId)
            .replacingOccurrences(of: W3CCommands.Id.Element.rawValue, with: elementId)
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
