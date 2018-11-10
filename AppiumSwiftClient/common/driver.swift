//
//  driver.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

protocol Driver {
    typealias SessionId = String

    func createSession(with caps: AppiumCapabilities) -> String
}

public struct AppiumDriver : Driver {

    public var sessionId: String = ""

    public init(_ caps: AppiumCapabilities) {
        self.sessionId = handShake(desiredCapability: caps)
    }

    private func handShake(desiredCapability: AppiumCapabilities) -> SessionId {
        let session = createSession(with: desiredCapability)
        return session
    }

    internal func createSession(with caps: AppiumCapabilities) -> String {
        let createSessionJson = generateCapabilityBody(with: caps)
        // TODO: send HTTP request to server as JSON format

        return createSessionJson
    }

    private func generateCapabilityBody(with caps: AppiumCapabilities) -> String {
        let invalidJson = "Not a valid JSON"


        let oSSdesiredCapability = OssDesiredCapability(with: caps)

        let w3cDesiredCapability = W3CDesiredCapability(with: caps)
        let w3cFirstMatch = W3CFirstMatch(firstMatch: [w3cDesiredCapability])

        let w3cCapability = W3CCapability(desiredCapabilities: oSSdesiredCapability, capabilities: w3cFirstMatch)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        do {
            let json = try encoder.encode(w3cCapability)
            return String(data: json, encoding: .utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}

internal struct W3CCapability : Codable {
    let desiredCapabilities : OssDesiredCapability
    let capabilities : W3CFirstMatch
}

internal struct W3CFirstMatch : Codable {
    let firstMatch : [W3CDesiredCapability]
}
