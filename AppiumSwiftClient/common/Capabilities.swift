//
//  Capabilities.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

public enum DesiredCapabilities : String {
    case platformName, automationName, app, platformVersion, deviceName
}

public protocol Capabilities {
    // protocol
}

public struct AppiumCapabilities : Capabilities {

    var desiredCapability : [DesiredCapabilities: String] = [:]

    public init(_ opts : [DesiredCapabilities: String]) {
        guard let platformName = opts[.platformName] else {
            fatalError("platformName is mondatory")
        }
        self.desiredCapability[.platformName] = platformName

        guard let automationName = opts[.automationName] else {
            fatalError("automationName is mondatory")
        }
        self.desiredCapability[.automationName] = automationName

        guard let app = opts[.app] else {
            fatalError("app is mondatory")
        }
        self.desiredCapability[.app] = app

        guard let platformVersion = opts[.platformVersion] else {
            fatalError("platformVersion is mondatory")
        }
        self.desiredCapability[.platformVersion] = platformVersion

        guard let deviceName = opts[.deviceName] else {
            fatalError("deviceName is mondatory")
        }
        self.desiredCapability[.deviceName] = deviceName
    }

    public func capabilities() -> [DesiredCapabilities : String] {
        return desiredCapability
    }
}
