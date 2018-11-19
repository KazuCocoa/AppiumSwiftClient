//
//  Click.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CElementClick: CommandProtocol {
    private let noElement = "no element"

    func sendRequest(_ elementId: Element.Id, with sessionId: Session.Id) -> String {
        let json = generateBodyData()
        let (statusCode, returnValue) =
            HttpClient().sendSyncRequest(method: W3CCommands.elementClick.0,
                                         commandPath: commandUrl(with: sessionId, and: elementId),
                                         json: json)

        if statusCode == 200 {
            return returnValue["value"] as! String // swiftlint:disable:this force_cast
        } else if statusCode == 400 {
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
        return W3CCommands().url(for: W3CCommands.elementClick, with: sessionId, and: elementId)
    }

    func generateBodyData() -> Data {
        let invalidJson = "invalid JSON"

        let elementClickParam = CommandParam()

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(elementClickParam)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
    }
}
