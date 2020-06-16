//
//  GetLogs.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 27.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias Log = Result<[LogEntry], Error>
struct W3CGetLog: CommandProtocol {

    private let command = W3CCommands.getLog
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest(and logType: String) -> Log {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl,
                                         json: generateBodyData(type: logType))
        guard statusCode == 200 else {
            print("Command Get Log \(logType) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<[LogEntry]>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }

    func generateBodyData(type logType: String) -> Data {
        let getLog = CommandParam(type: logType)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(getLog.toDictionary())
        } catch {
            return "Invalid JSON".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let type: String

        func toDictionary() -> [String: String] {
            return ["type": type.self]
        }
    }
}

public struct LogEntry: Codable {
    let message: String
    let level: String
    let timestamp: Int
}
