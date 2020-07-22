//
//  Displayed.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 20.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias ElementDisplayed = Result<Bool, Error>
struct W3CElementDisplayed: CommandProtocol {

    private let command = W3CCommands.isElementDisplayed
    private let sessionId: Session.Id
    private let elementId: MobileElement.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id, elementId: MobileElement.Id) {
        self.sessionId = sessionId
        self.elementId = elementId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId, and: elementId)
    }

    func sendRequest() -> ElementDisplayed {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)

        guard statusCode == 200 else {
            print("Command Element Displayed of Element \(elementId) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<Bool>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}
