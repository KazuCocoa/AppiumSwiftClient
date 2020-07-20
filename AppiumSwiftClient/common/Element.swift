//
//  Element.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation
import UIKit

protocol Element {
    func click() -> Click
    func getBase64Screenshot() -> TakeScreenshot
    func sendKeys(with text: String) -> SendKeys
    func clear() -> Clear
    func getText() throws -> String
    func getTagName() throws -> String
    func getElementAttribute(with attributeName: String) throws -> String
    func isSelected() throws -> Bool
    func isEnabled() throws -> Bool
}

public struct MobileElement: Element {
    public typealias Id = String // swiftlint:disable:this type_name

    public let id: Id // swiftlint:disable:this identifier_name
    public let sessionId: Session.Id // TODO: remove session id from element class since it should not depend on here

    init(id: Id, sessionId: Session.Id) { // swiftlint:disable:this identifier_name
        self.id = id
        self.sessionId = sessionId
    }

    @discardableResult public func click() -> Click {
        return W3CElementClick(sessionId: sessionId).sendRequest(id)
    }

    public func getBase64Screenshot() -> TakeScreenshot {
        return W3CElementScreenshot(sessionId: sessionId).sendRequest(id)
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

    @discardableResult public func sendKeys(with text: String) -> SendKeys {
        return W3CElementSendKeys(sessionId: sessionId, elementId: id).sendRequest(text)
    }

    @discardableResult public func clear() -> Clear {
        return W3CElementClear(sessionId: sessionId, elementId: id).sendRequest()
    }

    public func getText() throws -> String {
        return try W3CGetElementText(sessionId: sessionId, elementId: id).sendRequest().get()
    }

    public func getTagName() throws -> String {
        return try W3CGetElementTagName(sessionId: sessionId, elementId: id).sendRequest().get()
    }

    public func getElementAttribute(with attributeName: String) throws -> String {
        return try W3CGetElementAttribute(sessionId: sessionId, elementId: id).sendRequest(attribute: attributeName).get()
    }

    public func isSelected() throws -> Bool {
        return try W3CElementSelected(sessionId: sessionId, elementId: id).sendRequest().get()
    }

    public func isEnabled() throws -> Bool {
        return try W3CElementEnabled(sessionId: sessionId, elementId: id).sendRequest().get()
    }
}
