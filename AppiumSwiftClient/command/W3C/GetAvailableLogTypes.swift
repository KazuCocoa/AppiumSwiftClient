//
//  GetLogTypes.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 27.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias LogType = String
public typealias AvailableLogTypes = Result<[LogType], Error>
struct W3CGetAvailableLogTypes: CommandProtocol {

    private let command = W3CCommands.getAvailableLogTypes
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest() -> AvailableLogTypes {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)
        guard statusCode == 200 else {
            print("Command Get Available Log Types Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<[LogType]>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}
