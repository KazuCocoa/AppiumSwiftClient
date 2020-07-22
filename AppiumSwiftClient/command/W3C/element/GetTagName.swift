//
//  GetTagName.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 08.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias ElementTagName = Result<String, Error>
struct W3CGetElementTagName: CommandProtocol {

    private let command = W3CCommands.getElementTagName
    private let sessionId: Session.Id
    private let elementId: MobileElement.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id, elementId: MobileElement.Id) {
        self.sessionId = sessionId
        self.elementId = elementId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId, and: elementId)
    }

    func sendRequest() -> ElementTagName {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)

        guard statusCode == 200 else {
            print("Command Get Tag Name of Element \(elementId) Failed for \(sessionId) with Status Code: \(statusCode)")
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
