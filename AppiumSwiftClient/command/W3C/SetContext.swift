//
//  SetContext.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/12/31.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

public typealias SetContext = Result<String, Error>
struct W3CSetContext: CommandProtocol {

    private let command = W3CCommands.setContext
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest(with context: String) -> SetContext {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl,
                                         json: generateBodyData(context))

        guard statusCode == 200 else {
            print("Command Set Context \(context) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        return .success("")
    }

    func generateBodyData(_ context: String) -> Data {
        let invalidJson = "invalid JSON"

        let getCapabilitiesParam = CommandParam(name: context)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(getCapabilitiesParam)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let name: String
    }
}
