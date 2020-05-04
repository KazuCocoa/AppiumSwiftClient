//
//  EndSession.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 03.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CEndSession: CommandProtocol {
    func sendRequest(with sessionId: Session.Id) -> String {
        let json = generateBodyData()
        let (statusCode, returnValue) =
            HttpClient().sendSyncRequest(method: W3CCommands.deleteSession.0,
                                         commandPath: commandUrl(with: sessionId),
                                         json: json)

        if statusCode == 404 {
            print("Status Code \(statusCode): No Session with id \(sessionId) found?")
            print(returnValue)
        }
        return ""
    }

    func commandUrl(with sessionId: Session.Id, and _: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.deleteSession, with: sessionId)
    }

    func generateBodyData() -> Data {
        let elementClickParam = CommandParam()

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(elementClickParam)
        } catch {
            return "{}".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
    }
}
