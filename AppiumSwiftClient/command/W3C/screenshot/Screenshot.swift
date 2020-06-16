//
//  Screenshot.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2019/01/01.
//  Copyright © 2019 KazuCocoa. All rights reserved.
//

import Foundation

public typealias TakeScreenshot = Result<String, Error>
struct W3CScreenshot: CommandProtocol {

    private let command = W3CCommands.takeScreenshot
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest() -> TakeScreenshot {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)

        guard statusCode == 200 else {
            print("Command Get Screenshot Failed for \(sessionId) with Status Code: \(statusCode)")
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
