//
//  PageLoadTimeout.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 06.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CTimeout: CommandProtocol {
    func sendRequest(with sessionId: Session.Id,
                     and timeoutType: TimeoutTypesEnum,
                     and timeoutInMilliseconds: Int) throws -> String {
        let json = generateBodyData(with: timeoutType, and: timeoutInMilliseconds)
        let (statusCode, returnValue) =
        HttpClient().sendSyncRequest(method: W3CCommands.setTimeout.0,
                                     commandPath: commandUrl(with: sessionId),
                                     json: json)
        if statusCode == 200 {
            return ""
        } else {
            print("invalid parameter")
            print(returnValue)
            let webDriverError = WebDriverError(errorResult: returnValue["value"] as! [String: String]) // swiftlint:disable:this force_cast
            try webDriverError.raise()
            return ""
        }
    }

    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.setTimeout, with: sessionId)
    }

    private func generateBodyData(with timeoutType: TimeoutTypesEnum, and timeoutInMilliseconds: Int) -> Data {
        let timeoutData = CommandParam(type: timeoutType.rawValue, value: timeoutInMilliseconds)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        do {
            return try encoder.encode(timeoutData.toDictionary())
        } catch {
            return "Invalid JSON".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let type: String
        let value: Int

        func toDictionary() -> [String: Int] {
            return NSDictionary(dictionary: [type: value]) as! [String: Int] // swiftlint:disable:this force_cast
        }
    }
}

enum TimeoutTypesEnum: String {
    case script, pageLoad, implicit
}
