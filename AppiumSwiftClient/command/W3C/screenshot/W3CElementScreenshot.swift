//
//  W3CElementScreenshot.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2019/01/02.
//  Copyright © 2019 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CElementScreenshot: CommandProtocol {

    private let command = W3CCommands.takeElementScreenshot
    private let sessionId: Session.Id

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
    }

    func sendRequest(_ elementId: Element.Id) -> TakeScreenshot {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl(with: elementId))

        guard statusCode == 200 else {
            print("Command Get Screenshot for Element with id \(elementId) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<String>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }

    func commandUrl(with elementId: Element.Id) -> W3CCommands.CommandPath {
        return W3CCommands().url(for: command, with: sessionId, and: elementId)
    }
}
