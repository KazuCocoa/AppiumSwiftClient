//
//  GetOrientation.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 11.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias ScreenOrientation = String
public typealias GetScreenOrientation = Result<ScreenOrientation, Error>
struct W3CGetScreenOrientation: CommandProtocol {

    private let command = W3CCommands.getScreenOrientation
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest() -> GetScreenOrientation {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)
        guard statusCode == 200 else {
            print("Command Get Screen Orientation Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<ScreenOrientation>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}

public struct GetScreenOrientationResult: Decodable {
}
