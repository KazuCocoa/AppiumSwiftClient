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
    func findElement(by locator: SearchContext, with value: String) throws -> Element
    func findElements(by locator: SearchContext, with value: String) throws -> [Element]
    func getCapabilities() -> [String: Any]
    func getAvailableContexts() -> [String]
    func getCurrentContext() -> String
    func setContext(name: String) throws -> String
    func getBase64Screenshot() -> String
    func saveScreenshot(to filePath: String) -> String
    func getPageSource() throws -> String
    func back() throws -> String
    func setImplicitTimeout(timeoutInMillisencods: Int) throws -> String
    func setPageLoadTimeout(timeoutInMillisencods: Int) throws -> String
    func setScriptTimeout(timeoutInMillisencods: Int) throws -> String
    func setTimeout(with timeoutType: TimeoutTypesEnum, and timeoutInMilliseconds: Int) throws -> String
    func getScreenOrientation() throws -> String
    func rotate(to orientation: ScreenOrientationEnum) throws -> String
    func getSettings() throws -> [String: Any]
    func setSettings(this setting: SettingsEnum.RawValue, and value: AnyValue) throws -> String
    func setShouldUseCompactResponsesSetting(to value: Bool) throws -> String
    func setElementResponseAttributes(to value: String) throws -> String
    func quit() -> String
}

// sessionId should be global id.
// Will create Class as the driver. All of methods are struct. The class has them.
public class AppiumDriver: DriverProtocol {
    public var currentSessionCapabilities: AppiumCapabilities

    public var currentSession: Session = Session(id: "")

    public init(_ caps: AppiumCapabilities) throws {
        currentSessionCapabilities = caps

        currentSessionCapabilities = try handShake(desiredCapability: caps)
    }

    private func handShake(desiredCapability: AppiumCapabilities) throws -> AppiumCapabilities {
        var caps = desiredCapability.capabilities()

        // Must test fail if a create session fails
        let sessionId = try W3CCreateSession().sendRequest(with: desiredCapability)

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
    public func findElement(by locator: SearchContext, with value: String) throws -> Element {
        return try W3CFindElement().sendRequest(by: locator, with: value, to: currentSession.id)
    }

    public func findElements(by locator: SearchContext, with value: String) throws -> [Element] {
        return try W3CFindElements().sendRequest(by: locator, with: value, to: currentSession.id)
    }

    public func getCapabilities() -> [String: Any] {
        return W3CGetCapabilities().sendRequest(with: currentSession.id)
    }

    public func getAvailableContexts() -> [String] {
        return W3CAvailableContexts().sendRequest(with: currentSession.id)
    }

    public func getCurrentContext() -> String {
        return W3CCurrentContext().sendRequest(with: currentSession.id)
    }

    public func setContext(name: String) throws -> String {
        return try W3CSetContext().sendRequest(with: currentSession.id, andWith: name)
    }

    public func getBase64Screenshot() -> String {
        return W3CScreenshot().sendRequest(with: currentSession.id)
    }

    public func saveScreenshot(to filePath: String) -> String {
        let base64 = getBase64Screenshot()
        guard let data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
            return ""
        }
        let pngData = UIImage(data: data)?.pngData()

        let fileURL = FileManager.default.currentDirectoryPath.appending("/\(filePath)")
        // TODO: create a directory if the path has no full path
        //writing
        return FileManager.default.createFile(atPath: fileURL, contents: pngData) ? fileURL : ""
    }

    public func getBase64Screenshot(with element: Element) -> String {
        return W3CElementScreenshot().sendRequest(element.id, with: currentSession.id)
    }

    public func saveScreenshot(with element: Element, to filePath: String) -> String {
        let base64 = getBase64Screenshot(with: element)
        guard let data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
            return ""
        }
        let pngData = UIImage(data: data)?.pngData()

        let fileURL = FileManager.default.currentDirectoryPath.appending("/\(filePath)")
        // TODO: create a directory if the path has no full path
        //writing
        return FileManager.default.createFile(atPath: fileURL, contents: pngData) ? fileURL : ""
    }

    public func getPageSource() throws -> String {
        return try W3CGetPageSource().sendRequest(with: currentSession.id)
    }

    @discardableResult public func back() throws -> String {
        return try W3CGoBack().sendRequest(with: currentSession.id)
    }

    @discardableResult public func setImplicitTimeout(timeoutInMillisencods: Int) throws -> String {
        return try setTimeout(with: TimeoutTypesEnum.implicit, and: timeoutInMillisencods)
    }

    @discardableResult public func setPageLoadTimeout(timeoutInMillisencods: Int) throws -> String {
        return try setTimeout(with: TimeoutTypesEnum.pageLoad, and: timeoutInMillisencods)
    }

    @discardableResult public func setScriptTimeout(timeoutInMillisencods: Int) throws -> String {
        return try setTimeout(with: TimeoutTypesEnum.script, and: timeoutInMillisencods)
    }

    @discardableResult internal func setTimeout(with timeoutType: TimeoutTypesEnum, and timeoutInMilliseconds: Int) throws -> String {
        return try W3CTimeout().sendRequest(with: currentSession.id, and: timeoutType, and: 300)
    }

    public func getScreenOrientation() throws -> String {
        return try W3CGetScreenOrientation().sendRequest(with: currentSession.id)
    }

    @discardableResult public func rotate(to orientation: ScreenOrientationEnum) throws -> String {
        return try W3CSetScreenOrientation().sendRequest(with: currentSession.id, to: orientation)
    }

    public func getSettings() throws -> [String: Any] {
        return try W3CGetSettings().sendRequest(with: currentSession.id)
    }

    @discardableResult internal func setSettings(this setting: SettingsEnum.RawValue, and value: AnyValue) throws -> String {
        return try W3CSetSettings().sendRequest(with: currentSession.id, and: setting, to: value)
    }

    @discardableResult public func setShouldUseCompactResponsesSetting(to value: Bool) throws -> String {
        return try setSettings(this: SettingsEnum.shouldUseCompactResponses.rawValue, and: AnyValue(value))
    }

    @discardableResult public func setElementResponseAttributes(to value: String) throws -> String {
        return try setSettings(this: SettingsEnum.elementResponseAttributes.rawValue, and: AnyValue(value))
    }

    @discardableResult public func quit() -> String {
        return W3CEndSession().sendRequest(with: currentSession.id)
    }
}
