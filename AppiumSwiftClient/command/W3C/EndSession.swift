//
//  EndSession.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 03.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias EndSession = Result<String, Error>
struct W3CEndSession: CommandProtocol {

    private let command = W3CCommands.deleteSession
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest() -> EndSession {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)
        guard statusCode == 200 else {
            print("Command Quit Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        return .success("")
    }
}
