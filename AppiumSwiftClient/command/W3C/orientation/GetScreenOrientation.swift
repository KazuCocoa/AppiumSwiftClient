//
//  GetOrientation.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 11.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CGetScreenOrientation: CommandProtocol {

    func sendRequest(with sessionId: Session.Id) throws -> String {
        let json = generateBodyData()
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.getScreenOrientation.0,
                                                                     commandPath: commandUrl(with: sessionId),
                                                                     json: json)
        if statusCode == 200 {
            return returnValue["value"] as! String // swiftlint:disable:this force_cast
        } else {
            print("Status Code \(statusCode)")
            print(returnValue)
            // swiftlint:disable force_cast
            let webDriverError = WebDriverError(errorResult: returnValue["value"] as! [String: String])
            try webDriverError.raise()
            return "Error Happened"
        }
    }

    func commandUrl(with sessionId: Session.Id, and _: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.getScreenOrientation, with: sessionId)
    }

    func generateBodyData() -> Data {
        let goBack = CommandParam()

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(goBack)
        } catch {
            return "{}".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
    }
    
}
