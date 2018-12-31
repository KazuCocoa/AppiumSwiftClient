//
//  SetContext.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/12/31.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CSetContext: CommandProtocol {
    func sendRequest(with sessionId: Session.Id, andWith context: String) throws -> String {
        let json = generateBodyData(context)
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.setContext.0,
                                                                     commandPath: commandUrl(with: sessionId),
                                                                     json: json)

        if statusCode == 200 {
            // Appium returns NSNull as returnValue["value"]
            return ""
        } else if statusCode == 400 {
            // Encountered internal error running command: NoSuchContextError: No such context found.
            // swiftlint:disable force_cast
            let webDriverError = WebDriverError(errorResult: returnValue["value"] as! [String: String])
            // TODO: Should add tests
            try webDriverError.raise()
            return ""
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
