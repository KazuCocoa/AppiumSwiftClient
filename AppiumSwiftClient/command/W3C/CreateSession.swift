//
//  CreateSession.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

// TODO: Error handling for below case.
//Test Suite 'DriverTest' started at 2018-11-19 00:25:09.214
//Test Case '-[AppiumSwiftClientUnitTests.DriverTest testCreateSession]' started.
//2018-11-19 00:25:09.424581+0900 xctest[3011:64950] TIC TCP Conn Failed [1:0x7f84f480e030]: 1:61 Err(61)
//2018-11-19 00:25:09.436805+0900 xctest[3011:64950] Task <70F6243C-2CEE-41A8-9F5F-1A009005A6FC>.
// <1> HTTP load failed (error code: -1004 [1:61])
//2018-11-19 00:25:09.437206+0900 xctest[3011:64436] Task <70F6243C-2CEE-41A8-9F5F-1A009005A6FC>.
// <1> finished with error - code: -1004
//Error calling POST on http://127.0.0.1:4723/wd/hub/session
struct W3CCreateSession: CommandProtocol {

    private let command = W3CCommands.newSession
    private let commandUrl: W3CCommands.CommandPath
    public typealias CreateSession = Result<SessionDetails, Error>

    init() {
        self.commandUrl = command.1
    }

    func sendRequest(with caps: AppiumCapabilities) throws -> CreateSession {
        let (statusCode, returnData) =
        HttpClient().sendSyncRequest(method: command.0,
                                     commandPath: commandUrl,
                                     json: generateBodyData(with: caps))

        guard statusCode == 200 else {
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<SessionDetails>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }

    func generateBodyData(with caps: AppiumCapabilities) -> Data {
        let invalidJson = "Not a valid JSON"

        let oSSdesiredCapability = OssDesiredCapability(with: caps)

        let w3cDesiredCapability = W3CDesiredCapability(with: caps)
        let capabilities = W3CCapability(alwaysMatch: w3cDesiredCapability, firstMatch: [])

        let w3cCapability = CommandParam(desiredCapabilities: oSSdesiredCapability, capabilities: capabilities)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(w3cCapability)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let desiredCapabilities: OssDesiredCapability
        let capabilities: W3CCapability
    }

    fileprivate struct W3CCapability: CommandParamProtocol {
        let alwaysMatch: W3CDesiredCapability
        let firstMatch: [W3CDesiredCapability]
    }
}

public struct SessionDetails: Decodable {
    let sessionId: String
}
