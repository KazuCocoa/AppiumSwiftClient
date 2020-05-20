//
//  SetSettings.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 20.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CSetSettings: CommandProtocol {
    func sendRequest(with sessionId: Session.Id, and setting: SettingsEnum, to value: AnyValue) throws -> String {
        let json = generateBodyData(setting: setting, value: value)
        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.setSettings.0, commandPath: commandUrl(with: sessionId), json: json)
        if statusCode == 200 {
            return ""
        } else {
            print("invalid parameter")
            print(returnValue)
            let webDriverError = WebDriverError(errorResult: returnValue["value"] as! [String: String]) // swiftlint:disable:this force_cast
            try webDriverError.raise()
            return ""
        }
    }
    func commandUrl(with sessionId: Session.Id, and _: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.setSettings, with: sessionId)
    }

    func generateBodyData(setting: SettingsEnum, value: AnyValue) -> Data {
        let setSettings = CommandParam(setting: setting.rawValue, value: value)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(setSettings.toDictionary())
        } catch {
            return "{}".data(using: .utf8)!
        }
    }

    fileprivate struct CommandParam: CommandParamProtocol {
        let setting: String
        let value: AnyValue

        func toDictionary() -> [String: [String: AnyValue]] {
            return ["settings": [setting: value]]
        }
    }
}

public enum SettingsEnum: String {
    // Android and iOS
    case shouldUseCompactResponses
    case elementResponseAttributes
    // Android Only
    case ignoreUnimportantViews
    case waitForIdleTimeout
    case waitForSelectorTimeout
    case scrollAcknowledgmentTimeout
    case actionAcknowledgmentTimeout
    case allowInvisibleElements
    case enableNotificationListener
    case normalizeTagNames
    case keyInjectionDelay
    case shutdownOnPowerDisconnect
    case trackScrollEvents
    //iOS Only
    case nativeWebTap
    case mjpegServerScreenshotQuality
    case mjpegServerFramerate
    case screenshotQuality
    case mjpegScalingFactor
    case keyboardAutocorrection
    case keyboardPrediction
    case snapshotTimeout
    case snapshotMaxDepth
    case useFirstMatch
    case reduceMotion
    case defaultActiveApplication
    case activeAppDetectionPoint
    case includeNonModalElements
    case acceptAlertButtonSelector
    case dismissAlertButtonSelector
    case screenshotOrientation
    // All Platforms
    case imageElementTapStrategy
    case imageMatchThreshold
    case fixImageFindScreenshotDims
    case fixImageTemplateSize
    case checkForImageElementStaleness
    case autoUpdateImageElementPosition
    case fixImageTemplateScale
    case defaultImageTemplateScale
    case getMatchedImageResult
}
