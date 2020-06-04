//
//  CurrentContext.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/12/31.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

public typealias CurrentContext = Result<Context, Error>
struct W3CCurrentContext: CommandProtocol {

    private let command = W3CCommands.getCurrentContext
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command,
                                            with: sessionId)
    }

    func sendRequest() -> CurrentContext {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)

        guard statusCode == 200 else {
            print("Command Get Current Context Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<Context>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}
