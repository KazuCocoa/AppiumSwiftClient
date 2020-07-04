//
//  driver.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation
import UIKit // For screenshot

protocol DriverProtocol {
    var currentSessionCapabilities: AppiumCapabilities { get }
    func findElement(by locator: SearchContext, with value: String) throws -> MobileElement
    func findElements(by locator: SearchContext, with value: String) throws -> [MobileElement]
    func getCapabilities() -> GetCapabilities
    func getAvailableContexts() -> AvailableContexts
    func getCurrentContext() -> CurrentContext
    func setContext(name: String) -> SetContext
    func getBase64Screenshot() -> TakeScreenshot
    func saveScreenshot(to filePath: String) throws -> String
    func getPageSource() -> PageSource
    func back() -> Back
    func setImplicitTimeout(timeoutInMillisencods: Int) -> Timeout
    func setPageLoadTimeout(timeoutInMillisencods: Int) -> Timeout
    func setScriptTimeout(timeoutInMillisencods: Int) -> Timeout
    func setTimeout(with timeoutType: TimeoutTypesEnum, and timeoutInMilliseconds: Int) -> Timeout
    func getScreenOrientation() -> GetScreenOrientation
    func rotate(to orientation: ScreenOrientationEnum) -> SetScreenOrientation
    func getSettings<T: Decodable>() -> GetSettings<T>
    func setSettings(this setting: SettingsEnum.RawValue, and value: AnyValue) -> SetSetting
    func setShouldUseCompactResponsesSetting(to value: Bool) -> SetSetting
    func setElementResponseAttributes(to value: String) -> SetSetting
    func getAvailableLogTypes() -> AvailableLogTypes
    func getLog(logType: String) -> Log
    func getServerLog() -> Log
    func logEvent(with vendorName: String, and eventName: String) -> LogEvent
    func getEvents() throws -> EventsResult
    func quit() -> EndSession
}

// sessionId should be global id.
// Will create Class as the driver. All of methods are struct. The class has them.
public class AppiumDriver: DriverProtocol {

    public var currentSessionCapabilities: AppiumCapabilities

    public var currentSession: Session = Session(id: "")

    // TODO refactor init to accept endpoint and let default value to local wd bug url
    public init(_ caps: AppiumCapabilities) throws {
        currentSessionCapabilities = caps

        currentSessionCapabilities = try handShake(desiredCapability: caps)
    }

    private func handShake(desiredCapability: AppiumCapabilities) throws -> AppiumCapabilities {
        var caps = desiredCapability.capabilities()

        // Must test fail if a create session fails
        let sessionId = try W3CCreateSession().sendRequest(with: desiredCapability).get().sessionId

        caps[.sessionId] = sessionId
        currentSession = Session(id: sessionId)

        return AppiumCapabilities(caps)
    }

    /**
     Get an element
     - Parameters:
         - locator: xx.
         - value: xx.
     **/
    public func findElement(by locator: SearchContext, with value: String) throws -> MobileElement {
        return try W3CFindElement(sessionId: currentSession.id).sendRequest(by: locator, with: value).get()
    }

    public func findElements(by locator: SearchContext, with value: String) throws -> [MobileElement] {
        return try W3CFindElements(sessionId: currentSession.id).sendRequest(by: locator, with: value).get()
    }

    public func getCapabilities() -> GetCapabilities {
        return W3CGetCapabilities(sessionId: currentSession.id).sendRequest()
    }

    public func getAvailableContexts() -> AvailableContexts {
        return W3CAvailableContexts(sessionId: currentSession.id).sendRequest()
    }

    public func getCurrentContext() -> CurrentContext {
        return W3CCurrentContext(sessionId: currentSession.id).sendRequest()
    }

    @discardableResult public func setContext(name: String) -> SetContext {
        return W3CSetContext(sessionId: currentSession.id).sendRequest(with: name)
    }

    public func getBase64Screenshot() -> TakeScreenshot {
        return W3CScreenshot(sessionId: currentSession.id).sendRequest()
    }

    public func saveScreenshot(to filePath: String) throws -> String {
        do {
            let base64 = try getBase64Screenshot().get()
            guard let data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
                return ""
            }
            let pngData = UIImage(data: data)?.pngData()

            let fileURL = FileManager.default.currentDirectoryPath.appending("/\(filePath)")
            // TODO: create a directory if the path has no full path
            //writing
            return FileManager.default.createFile(atPath: fileURL, contents: pngData) ? fileURL : ""
        } catch let error {
            print(error)
            throw NSError()
        }
    }

    public func getPageSource() -> PageSource {
        return W3CGetPageSource(sessionId: currentSession.id).sendRequest()
    }

    @discardableResult public func back() -> Back {
        return W3CGoBack(sessionId: currentSession.id).sendRequest()
    }

    @discardableResult public func setImplicitTimeout(timeoutInMillisencods: Int) -> Timeout {
        return setTimeout(with: TimeoutTypesEnum.implicit, and: timeoutInMillisencods)
    }

    @discardableResult public func setPageLoadTimeout(timeoutInMillisencods: Int) -> Timeout {
        return setTimeout(with: TimeoutTypesEnum.pageLoad, and: timeoutInMillisencods)
    }

    @discardableResult public func setScriptTimeout(timeoutInMillisencods: Int) -> Timeout {
        return setTimeout(with: TimeoutTypesEnum.script, and: timeoutInMillisencods)
    }

    internal func setTimeout(with timeoutType: TimeoutTypesEnum, and timeoutInMilliseconds: Int) -> Timeout {
        return W3CTimeout(sessionId: currentSession.id).sendRequest(type: timeoutType, timeoutInMilliseconds: 300)
    }

    public func getScreenOrientation() -> GetScreenOrientation {
        return W3CGetScreenOrientation(sessionId: currentSession.id).sendRequest()
    }

    @discardableResult public func rotate(to orientation: ScreenOrientationEnum) -> SetScreenOrientation {
        return W3CSetScreenOrientation(sessionId: currentSession.id).sendRequest(to: orientation)
    }

    func getSettings<T: Decodable>() -> GetSettings<T> {
        return W3CGetSettings(sessionId: currentSession.id).sendRequest()
    }

    internal func setSettings(this setting: SettingsEnum.RawValue, and value: AnyValue) -> SetSetting {
        return W3CSetSettings(sessionId: currentSession.id).sendRequest(and: setting, to: value)
    }

    @discardableResult public func setShouldUseCompactResponsesSetting(to value: Bool) -> SetSetting {
        return setSettings(this: SettingsEnum.shouldUseCompactResponses.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setElementResponseAttributes(to value: String) -> SetSetting {
        return setSettings(this: SettingsEnum.elementResponseAttributes.rawValue, and: AnyValue(value))
    }

    public func getAvailableLogTypes() -> AvailableLogTypes {
        return W3CGetAvailableLogTypes(sessionId: currentSession.id).sendRequest()
    }

    public func getLog(logType: String) -> Log {
        return W3CGetLog(sessionId: currentSession.id).sendRequest(and: logType)
    }

    public func getServerLog() -> Log {
        return getLog(logType: "server")
    }

    @discardableResult public func logEvent(with vendorName: String, and eventName: String) -> LogEvent {
        return W3CLogEvent(sessionId: currentSession.id).sendRequest(vendorName: vendorName, eventName: eventName)
    }

    public func getEvents() throws -> EventsResult {
        switch W3CGetEvents(sessionId: currentSession.id).sendRequest() {
        case .value(let eventsResult):
            return eventsResult
        case .error(let error):
            throw error
        }
    }

    @discardableResult public func quit() -> EndSession {
        return W3CEndSession(sessionId: currentSession.id).sendRequest()
    }
}
