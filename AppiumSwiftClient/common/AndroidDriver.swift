//
//  AndroidDriver.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 21.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

protocol AndroidDriverProtocol: DriverProtocol {
    func setIgnoreUnimportantViews(to value: Bool) -> SetSetting
    func setWaitForIdleTimeout(timeInMilliseconds: Int) -> SetSetting
    func setWaitForSelectorTimeout(timeInMilliseconds: Int) -> SetSetting
    func setScrollAcknowledgmentTimeout(timeInMilliseconds: Int) -> SetSetting
    func setActionAcknowledgmentTimeout(timeInMilliseconds: Int) -> SetSetting
    func setAllowInvisibleElements(to value: Bool) -> SetSetting
    func setEnableNotificationListener(to value: Bool) -> SetSetting
    func setNormalizeTagNames(to value: Bool) -> SetSetting
    func setKeyInjectionDelay(timeInMilliseconds: Int) -> SetSetting
    func setShutdownOnPowerDisconnect(to value: Bool) -> SetSetting
    func setTrackScrollEvents(to value: Bool) -> SetSetting
    func getLogcat() -> Log
    func getBugReportLog() -> Log
}

public class AndroidDriver: AppiumDriver, AndroidDriverProtocol {

    public func getSettings() -> GetSettings<AndroidSettings> {
        return super.getSettings()
    }

    @discardableResult public func setIgnoreUnimportantViews(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.ignoreUnimportantViews.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setWaitForIdleTimeout(timeInMilliseconds: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.waitForIdleTimeout.rawValue, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setWaitForSelectorTimeout(timeInMilliseconds: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.waitForSelectorTimeout.rawValue, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setScrollAcknowledgmentTimeout(timeInMilliseconds: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.scrollAcknowledgmentTimeout.rawValue, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setActionAcknowledgmentTimeout(timeInMilliseconds: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.actionAcknowledgmentTimeout.rawValue, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setAllowInvisibleElements(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.allowInvisibleElements.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setEnableNotificationListener(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.enableNotificationListener.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setNormalizeTagNames(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.normalizeTagNames.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setKeyInjectionDelay(timeInMilliseconds: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.keyInjectionDelay.rawValue, and: AnyValue(timeInMilliseconds))
    }

    @discardableResult public func setShutdownOnPowerDisconnect(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.shutdownOnPowerDisconnect.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setTrackScrollEvents(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.trackScrollEvents.rawValue, and: AnyValue(value))
    }

    public func getLogcat() -> Log {
        return super.getLog(logType: "logcat")
    }

    public func getBugReportLog() -> Log {
        return super.getLog(logType: "bugreport")
    }
}
