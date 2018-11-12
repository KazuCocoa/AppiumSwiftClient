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

    public init(_ caps: AppiumCapabilities) {
        currentSessionCapabilities = caps

        currentSessionCapabilities = handShake(desiredCapability: caps)
    }

    private func handShake(desiredCapability: AppiumCapabilities) -> AppiumCapabilities {
        var caps = desiredCapability.capabilities()
        let sessionId = W3CCreateSession.sendRequest(with: desiredCapability)

        caps[.sessionId] = sessionId

        return AppiumCapabilities(caps)
    }
}
