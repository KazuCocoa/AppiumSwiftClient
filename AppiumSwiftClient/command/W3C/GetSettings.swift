//
//  GetSettings.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 19.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CGetSettings: CommandProtocol {
    func sendRequest(with sessionId: Session.Id) throws -> [String: Any] {
        let json = generateBodyData()
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.getSettings.0, commandPath: commandUrl(with: sessionId), json: json)
        if statusCode == 200 {
            return returnValue["value"] as! [String: Any] // swiftlint:disable:this force_cast
        } else {
            print("Command Get Settings Failed for \(sessionId) with Status Code: \(statusCode)")
            print(returnValue)
            let webDriverError = WebDriverError(errorResult: returnValue["value"] as! [String: String]) // swiftlint:disable:this force_cast
            try webDriverError.raise()
            return ["": ""]
        }
    }
    func commandUrl(with sessionId: Session.Id, and _: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.getSettings, with: sessionId)
    }

    func generateBodyData() -> Data {
        let getSettings = CommandParam()

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(getSettings)
        } catch {
            return "{}".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
    }
}
