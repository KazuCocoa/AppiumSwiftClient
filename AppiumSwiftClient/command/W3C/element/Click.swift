//
//  Click.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

public typealias Click = Result<String, Error>
struct W3CElementClick: CommandProtocol {

    private let command = W3CCommands.elementClick
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest(_ elementId: MobileElement.Id) -> Click {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl(with: sessionId, and: elementId),
                                         json: generateBodyData())

        guard statusCode == 200 else {
            print("Command Click on Element \(elementId) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        return .success("")
    }

    func commandUrl(with sessionId: Session.Id, and elementId: MobileElement.Id) -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.elementClick, with: sessionId, and: elementId)
    }

    func generateBodyData() -> Data {
        let invalidJson = "invalid JSON"

        let elementClickParam = CommandParam()

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(elementClickParam)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
    }
}
