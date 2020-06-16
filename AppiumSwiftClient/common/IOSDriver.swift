//
//  IOSDriver.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 21.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

protocol IOSDriverProtocol: DriverProtocol {
    func setNativeWebTap(to value: Bool) -> SetSetting
    func setMjpegServerScreenshotQuality(to value: Int) -> SetSetting
    func setMjpegServerFramerate(to value: Int) -> SetSetting
    func setScreenshotQuality(to value: Int) -> SetSetting
    func setMjpegScalingFactor(to value: Int) -> SetSetting
    func setKeyboardAutocorrection(to value: Bool) -> SetSetting
    func setKeyboardPrediction(to value: Bool) -> SetSetting
    func setSnapshotTimeout(timeoutInSeconds: Int) -> SetSetting
    func setSnapshotMaxDepth(to value: Int) -> SetSetting
    func setUseFirstMatch(to value: Bool) -> SetSetting
    func setReduceMotion(to value: Bool) -> SetSetting
    func setDefaultActiveApplication(to value: String) -> SetSetting
    func setActiveAppDetectionPoint(to value: Int) -> SetSetting
    func setIncludeNonModalElements(to value: Bool) -> SetSetting
    func setAcceptAlertButtonSelector(to value: String) -> SetSetting
    func setDismissAlertButtonSelector(to value: String) -> SetSetting
    func setScreenshotOrientation(to value: String) -> SetSetting
    func getSyslog() -> Log
    func getCrashlog() -> Log
    func getPerformanceLog() -> Log
    func getSafariConsoleLog() -> Log
    func getSafariNetworkLog() -> Log
}

public class IOSDriver: AppiumDriver, IOSDriverProtocol {

    public func getSettings() -> GetSettings<IOSSettings> {
        return super.getSettings()
    }

    @discardableResult public func setNativeWebTap(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.nativeWebTap.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setMjpegServerScreenshotQuality(to value: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.mjpegServerScreenshotQuality.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setMjpegServerFramerate(to value: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.mjpegServerFramerate.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setScreenshotQuality(to value: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.screenshotQuality.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setMjpegScalingFactor(to value: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.mjpegScalingFactor.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setKeyboardAutocorrection(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.keyboardAutocorrection.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setKeyboardPrediction(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.keyboardPrediction.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setSnapshotTimeout(timeoutInSeconds: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.snapshotTimeout.rawValue, and: AnyValue(timeoutInSeconds))
    }

    @discardableResult public func setSnapshotMaxDepth(to value: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.snapshotMaxDepth.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setUseFirstMatch(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.useFirstMatch.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setReduceMotion(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.reduceMotion.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setDefaultActiveApplication(to value: String) -> SetSetting {
        return setSettings(this: SettingsEnum.defaultActiveApplication.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setActiveAppDetectionPoint(to value: Int) -> SetSetting {
        return setSettings(this: SettingsEnum.activeAppDetectionPoint.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setIncludeNonModalElements(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.includeNonModalElements.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setAcceptAlertButtonSelector(to value: String) -> SetSetting {
        return setSettings(this: SettingsEnum.acceptAlertButtonSelector.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setDismissAlertButtonSelector(to value: String) -> SetSetting {
        return setSettings(this: SettingsEnum.dismissAlertButtonSelector.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setScreenshotOrientation(to value: String) -> SetSetting {
        return setSettings(this: SettingsEnum.screenshotOrientation.rawValue, and: AnyValue(value))
    }

    public func getSyslog() -> Log {
        return super.getLog(logType: "syslog")
    }

    public func getCrashlog() -> Log {
        return super.getLog(logType: "crashlog")
    }

    public func getPerformanceLog() -> Log {
        return super.getLog(logType: "performance")
    }

    public func getSafariConsoleLog() -> Log {
        return super.getLog(logType: "safariConsole")
    }

    public func getSafariNetworkLog() -> Log {
        return super.getLog(logType: "safariNetwork")
    }
}
