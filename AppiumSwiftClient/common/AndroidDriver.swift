//
//  AndroidDriver.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 21.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

protocol AndroidDriverProtocol: DriverProtocol {
    func setIgnoreUnimportantViews(to value: Bool) throws -> String
    func setWaitForIdleTimeout(timeInMilliseconds: Int) throws -> String
    func setWaitForSelectorTimeout(timeInMilliseconds: Int) throws -> String
    func setScrollAcknowledgmentTimeout(timeInMilliseconds: Int) throws -> String
    func setActionAcknowledgmentTimeout(timeInMilliseconds: Int) throws -> String
    func setAllowInvisibleElements(to value: Bool) throws -> String
    func setEnableNotificationListener(to value: Bool) throws -> String
    func setNormalizeTagNames(to value: Bool) throws -> String
    func setKeyInjectionDelay(timeInMilliseconds: Int) throws -> String
    func setShutdownOnPowerDisconnect(to value: Bool) throws -> String
    func setTrackScrollEvents(to value: Bool) throws -> String
}

public class AndroidDriver: AppiumDriver, AndroidDriverProtocol {

    @discardableResult public func setIgnoreUnimportantViews(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.ignoreUnimportantViews, and: AnyValue(value))
    }

    @discardableResult public func setWaitForIdleTimeout(timeInMilliseconds: Int) throws -> String {
        return try setSettings(this: SettingsEnum.waitForIdleTimeout, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setWaitForSelectorTimeout(timeInMilliseconds: Int) throws -> String {
        return try setSettings(this: SettingsEnum.waitForSelectorTimeout, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setScrollAcknowledgmentTimeout(timeInMilliseconds: Int) throws -> String {
        return try setSettings(this: SettingsEnum.scrollAcknowledgmentTimeout, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setActionAcknowledgmentTimeout(timeInMilliseconds: Int) throws -> String {
        return try setSettings(this: SettingsEnum.actionAcknowledgmentTimeout, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setAllowInvisibleElements(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.allowInvisibleElements, and: AnyValue(value))
    }

    @discardableResult public func setEnableNotificationListener(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.enableNotificationListener, and: AnyValue(value))
    }

    @discardableResult public func setNormalizeTagNames(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.normalizeTagNames, and: AnyValue(value))
    }

    @discardableResult public func setKeyInjectionDelay(timeInMilliseconds: Int) throws -> String {
        return try setSettings(this: SettingsEnum.keyInjectionDelay, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setShutdownOnPowerDisconnect(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.shutdownOnPowerDisconnect, and: AnyValue(value))
    }

    @discardableResult public func setTrackScrollEvents(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.trackScrollEvents, and: AnyValue(value))
    }
}
