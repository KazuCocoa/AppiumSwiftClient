//
//  GetSettings.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 19.05.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias GetSettings<T> = Result<T, Error>
struct W3CGetSettings: CommandProtocol {

    private let command = W3CCommands.getSettings
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
    }

    func sendRequest<T: Decodable>() -> GetSettings<T> {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)

        guard statusCode == 200 else {
            print("Command Get Settings Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<T>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}

public struct IOSSettings: Codable {
    let imageMatchThreshold: Double?
    let fixImageFindScreenshotDims: Bool?
    let fixImageTemplateSize: Bool?
    let fixImageTemplateScale: Bool?
    let defaultImageTemplateScale: Int?
    let checkForImageElementStaleness: Bool?
    let autoUpdateImageElementPosition: Bool?
    let imageElementTapStrategy: String?
    let getMatchedImageResult: Bool?
    let nativeWebTap: Bool?
    let nativeWebTapStrict: Bool?
    let useJSONSource: Bool?
    let shouldUseCompactResponses: Bool
    let elementResponseAttributes: String
    let mjpegServerScreenshotQuality: Int?
    let mjpegServerFramerate: Int?
    let screenshotQuality: Int?
    let mjpegScalingFactor: Int?
    let reduceMotion: Bool?
}

public struct AndroidSettings: Codable {
    let imageMatchThreshold: Double?
    let fixImageFindScreenshotDims: Bool?
    let fixImageTemplateSize: Bool?
    let fixImageTemplateScale: Bool?
    let defaultImageTemplateScale: Int?
    let checkForImageElementStaleness: Bool?
    let autoUpdateImageElementPosition: Bool?
    let imageElementTapStrategy: String?
    let getMatchedImageResult: Bool?
    let ignoreUnimportantViews: Bool?
    let allowInvisibleElements: Bool?
    let actionAcknowledgmentTimeout: Int?
    let elementResponseAttributes: String?
    let enableMultiWindows: Bool?
    let enableNotificationListener: Bool?
    let keyInjectionDelay: Int?
    let scrollAcknowledgmentTimeout: Int?
    let shouldUseCompactResponses: Bool?
    let waitForIdleTimeout: Int?
    let waitForSelectorTimeout: Int?
    let normalizeTagNames: Bool?
    let shutdownOnPowerDisconnect: Bool?
    let trackScrollEvents: Bool?
    let wakeLockTimeout: Int?
}
