//
//  IOSDriver.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 21.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

protocol IOSDriverProtocol: DriverProtocol {
    func setNativeWebTap(to value: Bool) throws -> String
    func setMjpegServerScreenshotQuality(to value: Int) throws -> String
    func setMjpegServerFramerate(to value: Int) throws -> String
    func setScreenshotQuality(to value: Int) throws -> String
    func setMjpegScalingFactor(to value: Int) throws -> String
    func setKeyboardAutocorrection(to value: Bool) throws -> String
    func setKeyboardPrediction(to value: Bool) throws -> String
    func setSnapshotTimeout(timeoutInSeconds: Int) throws -> String
    func setSnapshotMaxDepth(to value: Int) throws -> String
    func setUseFirstMatch(to value: Bool) throws -> String
    func setReduceMotion(to value: Bool) throws -> String
    func setDefaultActiveApplication(to value: String) throws -> String
    func setActiveAppDetectionPoint(to value: Int) throws -> String
    func setIncludeNonModalElements(to value: Bool) throws -> String
    func setAcceptAlertButtonSelector(to value: String) throws -> String
    func setDismissAlertButtonSelector(to value: String) throws -> String
    func setScreenshotOrientation(to value: String) throws -> String
}

public class IOSDriver: AppiumDriver, IOSDriverProtocol {

    @discardableResult public func setNativeWebTap(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.nativeWebTap.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setMjpegServerScreenshotQuality(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.mjpegServerScreenshotQuality.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setMjpegServerFramerate(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.mjpegServerFramerate.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setScreenshotQuality(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.screenshotQuality.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setMjpegScalingFactor(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.mjpegScalingFactor.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setKeyboardAutocorrection(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.keyboardAutocorrection.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setKeyboardPrediction(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.keyboardPrediction.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setSnapshotTimeout(timeoutInSeconds: Int) throws -> String {
        return try setSettings(this: SettingsEnum.snapshotTimeout.rawValue, and: AnyValue(timeoutInSeconds))
    }

    @discardableResult public func setSnapshotMaxDepth(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.snapshotMaxDepth.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setUseFirstMatch(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.useFirstMatch.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setReduceMotion(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.reduceMotion.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setDefaultActiveApplication(to value: String) throws -> String {
        return try setSettings(this: SettingsEnum.defaultActiveApplication.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setActiveAppDetectionPoint(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.activeAppDetectionPoint.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setIncludeNonModalElements(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.includeNonModalElements.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setAcceptAlertButtonSelector(to value: String) throws -> String {
        return try setSettings(this: SettingsEnum.acceptAlertButtonSelector.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setDismissAlertButtonSelector(to value: String) throws -> String {
        return try setSettings(this: SettingsEnum.dismissAlertButtonSelector.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setScreenshotOrientation(to value: String) throws -> String {
        return try setSettings(this: SettingsEnum.screenshotOrientation.rawValue, and: AnyValue(value))
    }
}
