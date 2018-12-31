//
//  SetContext.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/12/31.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CSetContext: CommandProtocol {
    func sendRequest(with sessionId: Session.Id, andWith context: String) -> String {
        let json = generateBodyData(context)
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.setContext.0,
                                                                     commandPath: commandUrl(with: sessionId),
                                                                     json: json)

        if statusCode == 200 {
            return returnValue["value"] as! String // swiftlint:disable:this force_cast
        } else {
            print("Status code is \(statusCode)")
            print(returnValue)
            return ""
        }
    }

    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.setContext, with: sessionId)
    }

    func generateBodyData(_ context: String) -> Data {
        let invalidJson = "invalid JSON"

        let getCapabilitiesParam = CommandParam(name: context)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(getCapabilitiesParam)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let name: String
    }
}
