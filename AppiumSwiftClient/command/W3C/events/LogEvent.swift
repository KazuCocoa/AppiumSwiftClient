//
//  LogEvent.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 19.06.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias LogEvent = Result<LogEventResponse, Error>
public typealias LogEventResponse = String
struct W3CLogEvent: CommandProtocol {

    private let command = W3CCommands.logEvent
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest(vendorName: String, eventName: String) -> LogEvent {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl,
                                         json: generateBodyData(vendorName: vendorName, eventName: eventName))
        guard statusCode == 200 else {
            print("Command Log Event \(eventName) with Vendor \(vendorName) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<LogEventResponse>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }

    func generateBodyData(vendorName: String, eventName: String) -> Data {
        let logEvent = CommandParam(vendor: vendorName, event: eventName)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(logEvent)
        } catch {
            return "Invalid JSON".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let vendor: String
        let event: String

        private enum CodingKeys: String, CodingKey {
            case vendor, event
        }
    }
}
