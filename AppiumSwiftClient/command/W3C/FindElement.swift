//
//  FindElement.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CFindElement : CommandProtocol {
    typealias ElementValue = [String: String] // {"element-6066-11e4-a52e-4f735466cecf": "element id"}
    private let noElement = "no element"

    static func sendRequest(by locator: SearchContext, with value: String, to sessionId: Session.Id) throws -> Element {
        let findElement = self.init()
        let json = findElement.generateFindElementBodyData(by: locator, with: value)

        let (statusCode, returnValue) = HttpClient().sendSyncRequest(method: W3CCommands.findElement.0,
                                                                     commandPath: findElement.commandUrl(with: sessionId),
                                                                     json: json)

        if (statusCode == 200) {
            return Element(id: findElement.elementIdFrom(param: returnValue["value"] as! ElementValue), sessionId: sessionId)
        } else if  (statusCode == 404) {
            print(returnValue)
//            ["value": {
//                error = "no such element";
//                message = "An element could not be located on the page using the given search parameters.";
//                stacktrace = "NoSuchElementError: An element could not be located on the page using the given search parameters.\n    at XCUITestDriver.<anonymous> (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/lib/commands/find.js:130:13)\n    at Generator.throw (<anonymous>)\n    at asyncGeneratorStep (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/node_modules/@babel/runtime/helpers/asyncToGenerator.js:3:24)\n    at _throw (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/node_modules/@babel/runtime/helpers/asyncToGenerator.js:29:9)\n    at <anonymous>";
//                }]
            let message = returnValue["value"] as! WebDriverErrorEnum.Error

            throw WebDriverErrorEnum.NoSuchElementError(error: message)
        } else {
            print("Status code is \(statusCode)")
            return Element(id: findElement.noElement, sessionId: sessionId)
        }
    }

    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id = "") -> W3CCommands.CommandPath {
        let urlBase = W3CCommands.findElement.1
        return urlBase
            .replacingOccurrences(of: W3CCommands.Id.Session.rawValue, with: sessionId)
    }

    private func generateFindElementBodyData(by locator: SearchContext, with value: String) -> Data {
        let invalidJson = "Not a valid JSON"

        let findElementParam = W3CFindElementParam(using: locator.rawValue, value: value)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(findElementParam)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    private func elementIdFrom(param: ElementValue) -> String {
        return param["ELEMENT"] ?? param["element-6066-11e4-a52e-4f735466cecf"] ?? noElement
    }

    private struct W3CFindElementParam : Codable {
        let using : String
        let value : String
    }
}
