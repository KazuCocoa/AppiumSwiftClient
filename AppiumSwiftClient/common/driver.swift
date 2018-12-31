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
public class AppiumDriver: Driver {

    public var currentSessionCapabilities: AppiumCapabilities

    public var currentSession: Session = Session(id: "")

    public init(_ caps: AppiumCapabilities) throws {
        currentSessionCapabilities = caps

        currentSessionCapabilities = try handShake(desiredCapability: caps)
    }

    private func handShake(desiredCapability: AppiumCapabilities) throws -> AppiumCapabilities {
        var caps = desiredCapability.capabilities()

        // Must test fail if a create session fails
        let sessionId = try W3CCreateSession().sendRequest(with: desiredCapability)

        caps[.sessionId] = sessionId
        currentSession = Session(id: sessionId)

        return AppiumCapabilities(caps)
    }

    /**
     Get an element
     - Parameters:
         - locator: xx.
         - value: xx.
     **/
    public func findElement(by locator: SearchContext, with value: String) throws -> Element {
        return try W3CFindElement().sendRequest(by: locator, with: value, to: currentSession.id)
    }

    public func findElements(by locator: SearchContext, with value: String) throws -> [Element] {
        return try W3CFindElements().sendRequest(by: locator, with: value, to: currentSession.id)
    }

    public func getCapabilities() -> [String: Any] {
        return W3CGetCapabilities().sendRequest(with: currentSession.id)
    }

    public func getAvailableContexts() -> [String] {
        return W3CAvailableContexts().sendRequest(with: currentSession.id)
    }

    public func getCurrentContext() -> String {
        return W3CCurrentContext().sendRequest(with: currentSession.id)
    }

    public func setContext(name: String) -> String {
        return W3CSetContext().sendRequest(with: currentSession.id, andWith: name)
    }
}
