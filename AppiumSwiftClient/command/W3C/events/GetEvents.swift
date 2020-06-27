//
//  GetEvents.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 19.06.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias Events = WebDriverResult<EventsResult>
struct W3CGetEvents: CommandProtocol {

    private let command = W3CCommands.getEvents
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest() -> WebDriverResult<EventsResult> {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)
        guard statusCode == 200 else {
            print("Command Get Events failed for session \(sessionId) with Status Code: \(statusCode)")
            return .error(WebDriverError(errorResult: returnData).raise())
        }
        // GF: This is ugly but still the most convienent way to return an object out of the Events endpoint response
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: returnData, options: []) as? [String: [String: AnyObject]]
            let eventsResult = jsonObj?["value"]?.reduce(into: EventsResult()) { result, key in
                if key.key == "commands" {
                    let commandArr = key.value as? [NSDictionary]
                    commandArr?.forEach { command in
                        result.commands.append(Command(cmd: command["cmd"] as! String, startTime: command["startTime"] as! Int, endTime: command["endTime"] as! Int))
                    }
                } else {
                    result.events[key.key] = (key.value as! [Int])
                }
            }
            guard eventsResult != nil else {
                return .error(ParsingError.null)
            }
            return .value(eventsResult!)
        } catch let error {
            return .error(error)
        }
    }
}

enum ParsingError: Error {
    case null
}

public struct EventsResult {
    var commands: [Command]
    var events: [String: [Int]]

    init() {
        self.commands = []
        self.events = [String: [Int]]()
    }
}

public struct Command: Decodable {
    let cmd: String
    let startTime: Int
    let endTime: Int
}
