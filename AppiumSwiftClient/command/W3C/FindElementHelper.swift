//
//  W3CFindElementHelper.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/18.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct W3CFindElementHelper {
    public typealias ElementValue = [String: String] // {"element-6066-11e4-a52e-4f735466cecf": "element id"}
    public typealias ElementsValue = [ElementValue] // [{"element-6066-11e4-a52e-4f735466cecf": "element id"}, {...:...}]
    let noElement = "no element"

    func generateBodyData(by locator: SearchContext, with value: String) -> Data {
        let invalidJson = "Not a valid JSON"

        let findElementParam = CommandParam(using: locator.rawValue, value: value)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(findElementParam)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }

    func elementIdFrom(param: ElementValue) -> String {
        return param["ELEMENT"] ?? param["element-6066-11e4-a52e-4f735466cecf"] ?? noElement
    }

    fileprivate struct CommandParam : CommandParamProtocol {
        let using : String
        let value : String
    }
}
