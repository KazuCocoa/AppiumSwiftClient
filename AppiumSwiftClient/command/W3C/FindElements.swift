//
//  FindElements.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/18.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CFindElements: CommandProtocol {
    private let helper: W3CFindElementHelper

    init() {
        helper = W3CFindElementHelper()
    }

    func sendRequest(by locator: SearchContext, with value: String, to sessionId: Session.Id) throws -> [Element] {
        let json = helper.generateBodyData(by: locator, with: value)

        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.findElements.0,
                                                                     commandPath: commandUrl(with: sessionId),
                                                                     json: json)

        if statusCode == 200 {
            return (returnValue["value"] as! W3CFindElementHelper.ElementsValue) // swiftlint:disable:this force_cast
                .map {
                    Element(id: helper.elementIdFrom(param: $0),
                            sessionId: sessionId)
            }
        } else if statusCode == 404 {
            print(returnValue)
            return []
        } else {
            print("Status code is \(statusCode)")
            return []
        }
    }

    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id = "") -> W3CCommands.CommandPath {
        return W3CCommands().url(for: W3CCommands.findElements, with: sessionId)
    }
}
