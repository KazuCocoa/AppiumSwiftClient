//
//  W3CElementScreenshot.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2019/01/02.
//  Copyright © 2019 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CElementScreenshot: CommandProtocol {
    func sendRequest(_ elementId: Element.Id, with sessionId: Session.Id) -> String {
        let json = generateBodyData()
        let (statusCode, returnValue) =
            HttpClient().sendSyncRequest(method: W3CCommands.takeElementScreenshot.0,
                                         commandPath: commandUrl(with: sessionId, and: elementId),
                                         json: json)

        if statusCode == 200 {
            // Return base64 encoded string
            return returnValue["value"] as! String // swiftlint:disable:this force_cast
        } else {
            print("Status code is \(statusCode)")
            print(returnValue)
            return ""
        }
    }

    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id) -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.takeElementScreenshot, with: sessionId, and: elementId)
    }

    func generateBodyData() -> Data {
        let invalidJson = "invalid JSON"

        let getCapabilitiesParam = CommandParam()

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(getCapabilitiesParam)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
    }
}
