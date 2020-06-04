//
//  SetSettings.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 20.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias SetSetting = Result<String, Error>
struct W3CSetSettings: CommandProtocol {

    private let command = W3CCommands.setSettings
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest(and setting: SettingsEnum.RawValue, to value: AnyValue) -> SetSetting {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl,
                                         json: generateBodyData(setting: setting, value: value))

        guard statusCode == 200 else {
            print("Command Set Setting \(setting) with Value \(value) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        return .success("")
    }

    func generateBodyData(setting: SettingsEnum.RawValue, value: AnyValue) -> Data {
        let setSettings = CommandParam(setting: setting, value: value)

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
