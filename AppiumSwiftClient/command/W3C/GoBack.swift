//
//  GoBack.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 05.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CGoBack: CommandProtocol {
    func sendRequest(with sessionId: Session.Id) throws -> String {
        let json = generateBodyData()
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.back.0, commandPath: commandUrl(with: sessionId), json: json)

        if statusCode == 200 {
            return ""
        } else {
            print("Command Go Back failed for session \(sessionId) with Status Code: \(statusCode)")
            print(returnValue)
            let webDriverError = WebDriverError(errorResult: returnValue["value"] as! [String: String]) // swiftlint:disable:this force_cast
            try webDriverError.raise()
            return "Can't go back."
        }
    }
    
    func commandUrl(with sessionId: Session.Id, and _: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.back, with: sessionId)
    }

    func generateBodyData() -> Data {
        let goBack = CommandParam()

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(goBack)
        } catch {
            return "{}".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
    }
}
