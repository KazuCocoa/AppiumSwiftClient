//
//  FindElements.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/18.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

public typealias FindElements = Result<[MobileElement], Error>
struct W3CFindElements: CommandProtocol {

    private let command = W3CCommands.findElements
    private let sessionId: Session.Id
    private let commandUrl: W3CCommands.CommandPath
    private let helper: W3CFindElementHelper

    init(sessionId: Session.Id) {
        self.sessionId = sessionId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId)
        helper = W3CFindElementHelper()
    }

    func sendRequest(by locator: SearchContext, with value: String) -> FindElements {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl,
                                         json: helper.generateBodyData(by: locator, with: value))

        guard statusCode == 200 else {
            print("Command Find Elements with Search Context \(locator.rawValue) and Value \(value) failed with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder()
                .decode(ValueOf<W3CFindElementHelper.ElementsValue>.self, from: returnData)
                .value
                .map { MobileElement(id: helper.elementIdFrom(param: $0), sessionId: sessionId) }
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}
