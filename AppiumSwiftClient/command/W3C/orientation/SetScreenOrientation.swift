//
//  SetScreenOrientation.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 11.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias SetScreenOrientation = Result<String, Error>
struct W3CSetScreenOrientation: CommandProtocol {

    private let command = W3CCommands.setScreenOrientation
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest(to orientation: ScreenOrientationEnum) -> SetScreenOrientation {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl,
                                         json: generateBodyData(with: orientation))
        guard statusCode == 200 else {
            print("Command Set Screen Orientation to \(orientation.rawValue) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        return .success("")
    }

    private func generateBodyData(with orientation: ScreenOrientationEnum) -> Data {
        let setOrientationData = CommandParam(value: orientation.rawValue)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        do {
            return try encoder.encode(setOrientationData.toDictionary())
        } catch {
            return "Invalid JSON".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let value: String

        func toDictionary() -> [String: String] {
            return ["orientation": value.self]
        }
    }
}
