//
//  PageLoadTimeout.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 06.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias Timeout = Result<String, Error>
struct W3CTimeout: CommandProtocol {

    private let command = W3CCommands.setTimeout
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest(type: TimeoutTypesEnum, timeoutInMilliseconds: Int) -> Timeout {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                                      commandPath: commandUrl,
                                                      json: generateBodyData(with: type, and: timeoutInMilliseconds))
        guard statusCode == 200 else {
            print("Command Set Timeout \(type.rawValue) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        return .success("")
    }

    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.setTimeout, with: sessionId)
    }

    private func generateBodyData(with timeoutType: TimeoutTypesEnum, and timeoutInMilliseconds: Int) -> Data {
        let timeoutData = CommandParam(type: timeoutType.rawValue, value: timeoutInMilliseconds)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        do {
            return try encoder.encode(timeoutData.toDictionary())
        } catch {
            return "Invalid JSON".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let type: String
        let value: Int

        func toDictionary() -> [String: Int] {
            return [type: value]
        }
    }
}

enum TimeoutTypesEnum: String {
    case script, pageLoad, implicit
}
