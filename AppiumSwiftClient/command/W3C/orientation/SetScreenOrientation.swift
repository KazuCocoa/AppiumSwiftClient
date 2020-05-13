//
//  SetScreenOrientation.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 11.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CSetScreenOrientation: CommandProtocol {

    func sendRequest(with sessionId: Session.Id, to orientation: ScreenOrientationEnum) throws -> String {
        let json = generateBodyData(with: orientation)
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.setScreenOrientation.0, commandPath: commandUrl(with: sessionId), json: json)

        if statusCode == 200 {
            return ""
        } else {
            print("Failed to set screen orientation to \(orientation.rawValue) with status code \(statusCode) on session \(sessionId)")
            print(returnValue)
            let webDriverError = WebDriverError(errorResult: returnValue["value"] as! [String: String]) // swiftlint:disable:this force_cast
            try webDriverError.raise()
            return ""
        }
    }

    func commandUrl(with sessionId: Session.Id, and _: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.setScreenOrientation, with: sessionId)
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
            return NSDictionary(dictionary: ["orientation": value.self]) as! [String: String] // swiftlint:disable:this force_cast
        }
    }
}
