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
        return try setSettings(this: SettingsEnum.nativeWebTap, and: AnyValue(value))
    }

    @discardableResult public func setMjpegServerScreenshotQuality(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.mjpegServerScreenshotQuality, and: AnyValue(value))
    }

    @discardableResult public func setMjpegServerFramerate(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.mjpegServerFramerate, and: AnyValue(value))
    }

    @discardableResult public func setScreenshotQuality(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.screenshotQuality, and: AnyValue(value))
    }

    @discardableResult public func setMjpegScalingFactor(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.mjpegScalingFactor, and: AnyValue(value))
    }

    @discardableResult public func setKeyboardAutocorrection(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.keyboardAutocorrection, and: AnyValue(value))
    }

    @discardableResult public func setKeyboardPrediction(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.keyboardPrediction, and: AnyValue(value))
    }

    @discardableResult public func setSnapshotTimeout(timeoutInSeconds: Int) throws -> String {
        return try setSettings(this: SettingsEnum.snapshotTimeout, and: AnyValue(timeoutInSeconds))
    }

    @discardableResult public func setSnapshotMaxDepth(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.snapshotMaxDepth, and: AnyValue(value))
    }

    @discardableResult public func setUseFirstMatch(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.useFirstMatch, and: AnyValue(value))
    }

    @discardableResult public func setReduceMotion(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.reduceMotion, and: AnyValue(value))
    }

    @discardableResult public func setDefaultActiveApplication(to value: String) throws -> String {
        return try setSettings(this: SettingsEnum.defaultActiveApplication, and: AnyValue(value))
    }

    @discardableResult public func setActiveAppDetectionPoint(to value: Int) throws -> String {
        return try setSettings(this: SettingsEnum.activeAppDetectionPoint, and: AnyValue(value))
    }

    @discardableResult public func setIncludeNonModalElements(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.includeNonModalElements, and: AnyValue(value))
    }

    @discardableResult public func setAcceptAlertButtonSelector(to value: String) throws -> String {
        return try setSettings(this: SettingsEnum.acceptAlertButtonSelector, and: AnyValue(value))
    }

    @discardableResult public func setDismissAlertButtonSelector(to value: String) throws -> String {
        return try setSettings(this: SettingsEnum.dismissAlertButtonSelector, and: AnyValue(value))
    }

    @discardableResult public func setScreenshotOrientation(to value: String) throws -> String {
        return try setSettings(this: SettingsEnum.screenshotOrientation, and: AnyValue(value))
    }
}
