//
//  SendKeys.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 01.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias SendKeys = Result<String, Error>
struct W3CElementSendKeys: CommandProtocol {

    private let command = W3CCommands.elementSendKeys
    private let sessionId: Session.Id
    private let elementId: MobileElement.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id, elementId: MobileElement.Id) {
        self.sessionId = sessionId
        self.elementId = elementId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId, and: elementId)
    }

    func sendRequest(_ text: String) -> SendKeys {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl,
                                         json: generateBodyData(elementId, text))

        guard statusCode == 200 else {
            print("Command Send Keys on Element \(elementId) with text \(text) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        return .success("")
    }

    func generateBodyData(_ elementId: MobileElement.Id, _ text: String) -> Data {
        let sendKeysData = CommandParam(id: elementId, value: text)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(sendKeysData)
        } catch {
            return "Invalid JSON".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let id: String // swiftlint:disable:this identifier_name
        let value: String

        private enum CodingKeys: String, CodingKey {
            case id, value // swiftlint:disable:this identifier_name
        }
    }
}
