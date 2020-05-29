//
//  GetLogs.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 27.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CGetLog: CommandProtocol {
    func sendRequest(with sessionId: Session.Id, and logType: String) throws -> [LogEntry] {
        let json = generateBodyData(type: logType)
        /*
         POC: User overload sendSyncRequest fuction that returns Data from response
         */
        let (statusCode, returnData) = HttpClient().sendSyncRequestReturningData(method: W3CCommands.getLog.0, commandPath: commandUrl(with: sessionId), json: json)

        /*
         POC: We should first check for status code and throw the appropriate WebDriverError in case
         the request fails, skipping decoding process to LogEntry type altogether.
         */
        guard statusCode == 200 else {
            print("Command Get Log \(logType) Failed for \(sessionId) with Status Code: \(statusCode)")
            let webDriverError = WebDriverError(errorResult: returnData)
            throw try webDriverError.raise()
        }

        /*
         POC: If request was succesful then we proceed with decoding Data into appropriate type. In this case, the response is a an Array of LogEntry.
         */
        let result = try JSONDecoder().decode(ValueArrayOf<LogEntry>.self, from: returnData)
        return result.value
    }

    func commandUrl(with sessionId: Session.Id, and _: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.getLog, with: sessionId)
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

/*
 POC: A struct that represents the LogEntry object from response
 */
public struct LogEntry: Codable {
    let message: String
    let level: String
    let timestamp: Int
}

/*
POC: Generic struct that accepts decodable conformant types that represents a driver response. It is meant
to be a reusable struct and should be placed in its own file and used whenever fit (Mostly POST request
responses as it does not decode sessionId value?)
*/
struct ValueArrayOf<T: Codable>: Codable {
    let value: [T]

    private enum CodingKeys: String, CodingKey {
        case value
    }

    init(from decoder: Decoder) {
        let container = try! decoder.container(keyedBy: CodingKeys.self) // swiftlint:disable:this force_try
        value = try! container.decode([T].self, forKey: .value) // swiftlint:disable:this force_try
    }
}
