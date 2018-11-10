//
//  Capabilities.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

public enum DesiredCapabilitiesEnum : String {
    case platformName, automationName, app, platformVersion, deviceName
}

public struct OssDesiredCapability : Codable {
    let platformName : String
    let automationName : String
    let app : String
    let platformVersion : String
    let deviceName : String

    init(with caps : AppiumCapabilities) {
        let desiredCaps = caps.desiredCapability
        platformName = desiredCaps[.platformName] ?? ""
        automationName = desiredCaps[.automationName] ?? ""
        app = desiredCaps[.app] ?? ""
        platformVersion = desiredCaps[.platformVersion] ?? ""
        deviceName = desiredCaps[.deviceName] ?? ""
    }
}

public struct W3CDesiredCapability : Codable {
    let platformName : String
    let automationName : String
    let app : String
    let platformVersion : String
    let deviceName : String

    init(with caps : AppiumCapabilities) {
        let desiredCaps = caps.desiredCapability
        platformName = desiredCaps[.platformName] ?? ""
        automationName = desiredCaps[.automationName] ?? ""
        app = desiredCaps[.app] ?? ""
        platformVersion = desiredCaps[.platformVersion] ?? ""
        deviceName = desiredCaps[.deviceName] ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case platformName, automationName, platformVersion, deviceName
        case app = "appium:app"
    }
}

public protocol Capabilities {
    typealias type = [DesiredCapabilitiesEnum: String]
    // protocol
}

public struct AppiumCapabilities : Capabilities {
    public typealias CapsType = Capabilities.type

    var desiredCapability : CapsType = [:]

    public init(_ opts : CapsType) {
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

    public func capabilities() -> CapsType {
        return desiredCapability
    }
}
