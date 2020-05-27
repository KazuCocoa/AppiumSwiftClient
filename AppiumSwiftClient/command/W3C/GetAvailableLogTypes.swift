//
//  GetLogTypes.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 27.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CGetAvailableLogTypes: CommandProtocol {
    func sendRequest(with sessionId: Session.Id) throws -> [String] {
        let json = generateBodyData()
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.getAvailableLogTypes.0, commandPath: commandUrl(with: sessionId), json: json)
        if statusCode == 200 {
            return returnValue["value"] as! [String] // swiftlint:disable:this force_cast
        } else {
            print("Command Get Available Log Types Failed for \(sessionId) with Status Code: \(statusCode)")
            print(returnValue)
            let webDriverError = WebDriverError(errorResult: returnValue["value"] as! [String: String]) // swiftlint:disable:this force_cast
            try webDriverError.raise()
            return [""]
        }
    }
    func commandUrl(with sessionId: Session.Id, and _: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.getAvailableLogTypes, with: sessionId)
    }

    func generateBodyData() -> Data {
        let getAvailableLogTypes = CommandParam()

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(getAvailableLogTypes)
        } catch {
            return "{}".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
    }
}
