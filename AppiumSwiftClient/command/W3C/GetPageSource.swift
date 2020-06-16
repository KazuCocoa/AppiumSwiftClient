//
//  GetPageSource.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 04.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias PageSource = Result<String, Error>
struct W3CGetPageSource: CommandProtocol {

    private let command = W3CCommands.getPageSource
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest() -> PageSource {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)
        guard statusCode == 200 else {
            print("Command Get Page Source Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<String>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}
