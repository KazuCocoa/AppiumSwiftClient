//
//  FindElement.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CFindElement: CommandProtocol {
    private let helper: W3CFindElementHelper

    init() {
        helper = W3CFindElementHelper()
    }

    func sendRequest(by locator: SearchContext, with value: String, to sessionId: Session.Id) throws -> Element {
        let json = helper.generateBodyData(by: locator, with: value)

        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.findElement.0,
                                                                     commandPath: commandUrl(with: sessionId),
                                                                     json: json)

        if statusCode == 200 {
            return Element(
                id: helper.elementIdFrom(param:
                    returnValue["value"] as! W3CFindElementHelper.ElementValue // swiftlint:disable:this force_cast
                ),
                sessionId: sessionId
            )
        } else if statusCode == 404 {
            // swiftlint:disable force_cast
            let webDriverError = WebDriverError(errorResult: returnValue["value"] as! [String: String])
            try webDriverError.raise()
            return Element(id: helper.noElement, sessionId: sessionId)
        } else {
            print("Status code is \(statusCode)")
            return Element(id: helper.noElement, sessionId: sessionId)
        }
    }

    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.findElement, with: sessionId)
    }
}
