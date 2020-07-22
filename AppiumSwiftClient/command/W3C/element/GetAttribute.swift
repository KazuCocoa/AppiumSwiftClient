//
//  GetAttribute.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 08.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias ElementAttribute = Result<String, Error>
struct W3CGetElementAttribute: CommandProtocol {

    private let command = W3CCommands.getElementAttribute
    private let sessionId: Session.Id
    private let elementId: MobileElement.Id

    init(sessionId: Session.Id, elementId: MobileElement.Id) {
        self.sessionId = sessionId
        self.elementId = elementId
    }

    func sendRequest(attribute: String) -> ElementAttribute {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: W3CCommands().url(for: command, with: sessionId, and: elementId, and: attribute))

        guard statusCode == 200 else {
            print("Command Get Attibute \(attribute) of Element \(elementId) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<String>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}
