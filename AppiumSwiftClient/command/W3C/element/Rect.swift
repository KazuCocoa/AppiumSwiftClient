//
//  Rect.swift
//  AppiumSwiftClient
//
//  Created by Gabriel Fioretti on 20.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation

public typealias ElementRect = Result<Rect, Error>
struct W3CElementRect: CommandProtocol {

    private let command = W3CCommands.getElementRect
    private let sessionId: Session.Id
    private let elementId: MobileElement.Id
    private let commandUrl: W3CCommands.CommandPath

    init(sessionId: Session.Id, elementId: MobileElement.Id) {
        self.sessionId = sessionId
        self.elementId = elementId
        self.commandUrl = W3CCommands().url(for: command, with: sessionId, and: elementId)
    }

    func sendRequest() -> ElementRect {
        let (statusCode, returnData) =
            HttpClient().sendSyncRequest(method: command.0,
                                         commandPath: commandUrl)

        guard statusCode == 200 else {
            print("Command Element Rect of \(elementId) Failed for \(sessionId) with Status Code: \(statusCode)")
            return .failure(WebDriverError(errorResult: returnData).raise())
        }
        do {
            let response = try JSONDecoder().decode(ValueOf<Rect>.self, from: returnData).value
            return .success(response)
        } catch let error {
            return .failure(error)
        }
    }
}

public struct Rect: Decodable {
    let width: Int
    let height: Int
    let xCoord: Int
    let yCoord: Int

    enum CodingKeys: String, CodingKey {
        case xCoord = "x"
        case yCoord = "y"
        case width, height
    }
}
