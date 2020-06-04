//
//  GetCapabilities.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/18.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

public typealias GetCapabilities = Result<SessionCapabilities, Error>
struct W3CGetCapabilities: CommandProtocol {

    private let command = W3CCommands.getCapabilities
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest() -> GetCapabilities {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)
        guard statusCode == 200 else {
            print("Command Capabilities Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<SessionCapabilities>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}

public struct SessionCapabilities: Codable {
    let udid: String?
    let platformName: String?
    let app: String?
    let platformVersion: String?
    let deviceName: String?
    let device: String?
    let browserName: String?
    let sdkVersion: String?
    let CFBundleIdentifier: String?
    let pixelRatio: Int?
    let statBarHeight: Int?
    let viewportRect: ViewportRect?
}

public struct ViewportRect: Codable {
    let left: Int
    let top: Int
    let width: Int
    let height: Int

    public func asDictionary() -> [String: Int] {
        return ["left": left, "top": top, "width": width, "height": height]
    }
}
