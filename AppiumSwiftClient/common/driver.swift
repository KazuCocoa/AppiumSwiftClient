//
//  driver.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

protocol Driver {
    // no
}

// sessionId should be global id.
// Will create Class as the driver. All of methods are struct. The class has them.
public class AppiumDriver : Driver {

    public var currentSessionCapabilities: AppiumCapabilities

    public var currentSession: Session = Session(id: "")

    public init(_ caps: AppiumCapabilities) {
        currentSessionCapabilities = caps

        currentSessionCapabilities = handShake(desiredCapability: caps)
    }

    private func handShake(desiredCapability: AppiumCapabilities) -> AppiumCapabilities {
        var caps = desiredCapability.capabilities()
        let sessionId = W3CCreateSession.sendRequest(with: desiredCapability)

        caps[.sessionId] = sessionId
        currentSession = Session(id: sessionId)

        return AppiumCapabilities(caps)
    }

    public func findElement(by locator: SearchContext, with value: String) -> Element {
        return W3CFindElement.sendRequest(by: locator, with: value, to: currentSession.id)
    }
}

public class Element {
    public let id: String

    init(id: String) {
        self.id = id
    }
}
